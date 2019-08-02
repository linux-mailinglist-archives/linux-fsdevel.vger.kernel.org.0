Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FFF7EAB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 05:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfHBDfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 23:35:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35826 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHBDfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:35:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htOM4-0001j9-Ou; Fri, 02 Aug 2019 03:35:45 +0000
Date:   Fri, 2 Aug 2019 04:35:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC] configfs_unregister_group() API
Message-ID: <20190802033544.GA5426@ZenIV.linux.org.uk>
References: <20190730211355.GU1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730211355.GU1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:13:55PM +0100, Al Viro wrote:
> 	AFAICS, it (and configfs_unregister_default_group())
> will break if called with group non-empty (i.e. when rmdir(2)
> would've failed with -ENOTEMPTY); configfs_detach_prep()
> is called, but return value is completely ignored.
> 
> 	Similar breakage happens in configfs_unregister_subsystem(),
> but there it looks like the drivers are responsible for not calling
> it that way.  It yells if configfs_detach_prep() fails and AFAICS
> all callers do guarantee it never happens.
> 
> 	configfs_unregister_group() is quiet; from my reading of
> the callers, only pci-endpoint might end up calling it for group
> that is not guaranteed to be empty.  I'm not familiar with
> pci-endpoint guts, so I might very well be missing something there.
> 
> Questions to configfs API maintainers (that'd be Christoph, these
> days, AFAIK)
> 
> 1) should such a call be considered a driver bug?
> 2) should configfs_unregister_group() at least warn when that happens?
> 
> and, to pci-endpoint maintainer
> 
> 3) what, if anything, prevents such calls in pci-endpoint?  Because
> as it is, configfs will break badly when that happens...

	More specifically, consider something like pci_epf_test_init()
calling pci_epf_register_driver().  Which, in turn, calls
pci_ep_cfs_add_epf_group() and hits
        group = configfs_register_default_group(functions_group, name,
                                                &pci_epf_group_type);
in there.  OK, so we get a directory tree created, with

static const struct config_item_type pci_epf_group_type = {
        .ct_group_ops   = &pci_epf_group_ops,
        .ct_owner       = THIS_MODULE,
};

for type.  Since pci_epf_group_ops is
static struct configfs_group_operations pci_epf_group_ops = {
        .make_group     = &pci_epf_make,
        .drop_item      = &pci_epf_drop,
};

and has ->make_group(), userland can do mkdir() in there.  Now,
doing so pins ->ct_owner, preventing module_exit() until we
rmdir() the sucker.  And configfs_default_group_unregister()
*IS* triggered by module_exit(), but it's the wrong module.
THIS_MODULE here refers to pci-ep-cfs, not pci-epf-test, so
it doesn't do a damn thing to prevent rmmod pci-epf-test,
calling
static void __exit pci_epf_test_exit(void)
{
        pci_epf_unregister_driver(&test_driver);
}
which leads to pci_ep_cfs_remove_epc_group(), with
	configfs_unregister_default_group(group);
in it.  What's to prevent that call on non-empty group?

	AFAICS, pci_ep_cfs_add_epc_group()/pci_ep_cfs_remove_epc_group()
might grow a similar problem, but these have no current users.

	Folks, should that be treated as bug in driver (as in
"don't you ever call configfs_unregister_{default_,}group() on
a non-empty group") or should that be dealt with in configfs?

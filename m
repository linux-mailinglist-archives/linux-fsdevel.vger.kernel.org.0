Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A53B766C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhF2Q2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 12:28:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52428 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232523AbhF2Q2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:28:30 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15TGPmRq028424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 12:25:49 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6B87915C3CD8; Tue, 29 Jun 2021 12:25:48 -0400 (EDT)
Date:   Tue, 29 Jun 2021 12:25:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>, dwalsh@redhat.com,
        Vivek Goyal <vgoyal@redhat.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <YNtJjDlGoBcg4kgS@mit.edu>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 07:38:15AM -0700, Casey Schaufler wrote:
> > IMHO the biggest problem is it's badly defined when you want to actually
> > share filesystems between guests or between guests and the host.
> 
> Right. The filesystem isn't the right layer for mapping xattrs.

Well, let's enumerate the alternatives:

* Some kind of stackable LSM?
* Some kind of FUSE-like scheme?
* Adding an eBPF hook which can perform the mapping

The last may be the best bet, since different use cases can use
different eBPF programs.  The eBPF script can handle both the mapping
as well some kind of specialized access control with respect to what
entities are allowed set or get xattrs.

> >>> It would be lovely if there was something more granular, (e.g. allowing
> >>> user.NUMBER. or trusted.NUMBER. to be used by this particular guest).
> >> We can't do that without breaking the "kernels aren't container aware"
> >> mandate.

eBPF scripts, since they are supplied by the user *can* be container
aware.  :-)

						- Ted

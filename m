Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA87B4DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 23:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbfG3VN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 17:13:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52748 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfG3VN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:13:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hsZRT-0003Vq-6d; Tue, 30 Jul 2019 21:13:55 +0000
Date:   Tue, 30 Jul 2019 22:13:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC] configfs_unregister_group() API
Message-ID: <20190730211355.GU1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	AFAICS, it (and configfs_unregister_default_group())
will break if called with group non-empty (i.e. when rmdir(2)
would've failed with -ENOTEMPTY); configfs_detach_prep()
is called, but return value is completely ignored.

	Similar breakage happens in configfs_unregister_subsystem(),
but there it looks like the drivers are responsible for not calling
it that way.  It yells if configfs_detach_prep() fails and AFAICS
all callers do guarantee it never happens.

	configfs_unregister_group() is quiet; from my reading of
the callers, only pci-endpoint might end up calling it for group
that is not guaranteed to be empty.  I'm not familiar with
pci-endpoint guts, so I might very well be missing something there.

Questions to configfs API maintainers (that'd be Christoph, these
days, AFAIK)

1) should such a call be considered a driver bug?
2) should configfs_unregister_group() at least warn when that happens?

and, to pci-endpoint maintainer

3) what, if anything, prevents such calls in pci-endpoint?  Because
as it is, configfs will break badly when that happens...

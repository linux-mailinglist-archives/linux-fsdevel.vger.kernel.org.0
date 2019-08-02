Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED547ECEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 08:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbfHBGxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 02:53:01 -0400
Received: from verein.lst.de ([213.95.11.211]:50167 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731644AbfHBGxB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:53:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A508868C65; Fri,  2 Aug 2019 08:52:57 +0200 (CEST)
Date:   Fri, 2 Aug 2019 08:52:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC] configfs_unregister_group() API
Message-ID: <20190802065257.GA7786@lst.de>
References: <20190730211355.GU1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730211355.GU1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
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

Yes, I'm patch monkeying these days.  From my POV expecting it to
act recursively seems like a bug, and we should at the very least warn.

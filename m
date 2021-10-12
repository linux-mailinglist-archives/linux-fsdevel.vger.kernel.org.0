Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A642A4D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 14:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhJLMvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 08:51:09 -0400
Received: from verein.lst.de ([213.95.11.211]:41317 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236326AbhJLMvI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:51:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8972067373; Tue, 12 Oct 2021 14:49:04 +0200 (CEST)
Date:   Tue, 12 Oct 2021 14:49:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 10/11] unicode: Add utf8-data module
Message-ID: <20211012124904.GB9518@lst.de>
References: <20210915070006.954653-1-hch@lst.de> <20210915070006.954653-11-hch@lst.de> <87wnmipjrw.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnmipjrw.fsf@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[fullquote deleted]

On Tue, Oct 12, 2021 at 08:25:23AM -0300, Gabriel Krisman Bertazi wrote:
> > @@ -187,6 +207,7 @@ EXPORT_SYMBOL(utf8_load);
> >  
> >  void utf8_unload(struct unicode_map *um)
> >  {
> > +	symbol_put(utf8_data_table);
> 
> This triggers a BUG_ON if the symbol isn't loaded/loadable,
> i.e. ext4_fill_super fails early.  I'm not sure how to fix it, though.

Does this fix it?

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 38ca824f10158..67aaadc3ab072 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -207,8 +207,10 @@ EXPORT_SYMBOL(utf8_load);
 
 void utf8_unload(struct unicode_map *um)
 {
-	symbol_put(utf8_data_table);
-	kfree(um);
+	if (um) {
+		symbol_put(utf8_data_table);
+		kfree(um);
+	}
 }
 EXPORT_SYMBOL(utf8_unload);
 

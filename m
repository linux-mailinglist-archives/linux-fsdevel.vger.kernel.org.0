Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E87CC6AA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 01:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbfJDXr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 19:47:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35853 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbfJDXr6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:47:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id h2so7531325edn.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2019 16:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iie7RdretcNOVCrxGCld/hubIoD9vvtdOTDz4FnA2dA=;
        b=oc+9qR+g1eb8AusmeETg+hxNkM4av/nlQqeoA/r10WqbNdvaWmgYdlL+vgffIwpUav
         ZmEHklwVDPPpz7VG1iApD2RV6aMl4GnMcu8iOA9fcjg7XC13XWQHCnrmMrflr3aRHcxn
         OUVvFzf1YqSVetu85aFudr/m9RrnBF0PDgqTxJk7Gn1sz7rCddkWUG0JFrsmSQNQ3I2i
         5Frkwkw/1IaGB4Vzlb/hdVx2+N2NrWmyL4XcvJh613ppRohfJfophVs5eelYLUMICDBw
         vDSKetrzpWC9pnQ9OVrqzdMKrm4BgBAhuhjoDHNcOwIzEKXqKBNjJDGd3aVFCOd7iJfg
         7gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iie7RdretcNOVCrxGCld/hubIoD9vvtdOTDz4FnA2dA=;
        b=Ras3ZhAmlH0kZEbmADU9+iQV5L+Ppw5wUneWnPddci1pkhu0yhhI3BkJrbQGwlLAJW
         lGeSb+hjL2Ir8WLdB83QQGPhlZumzY/EqpUIimnSB2PnxGhJcQDa6frAz9whCelkB8Qg
         v3EyGfMPYUK2K5XJvTxQmMiGo7/xYT+jtu5u4dskhMchwg0Sl16fO09wqVrfCJ65UvUM
         bf6aqdD+E4X9pr5x4oEG18sFMDXg/2WmbCjWRRYcLxeHpTUrVMgmNHArDGyBY7WIYeqU
         EI79ajUO96MoZUkJSVYrBm4X81ZbmiJcQYChkB4TcknMyVsyY//zcnKZ/AmwqsUZgB9z
         F19g==
X-Gm-Message-State: APjAAAXjiGzXQfTQekhcBkeFkwAWPYzTbhQz0MlZJVaeMMvBJp8gAwXz
        jznIEEU+FMoEnBKz686tCl/52Zo=
X-Google-Smtp-Source: APXvYqykrz4mpeaperO7K2jPAOR9caTvNx7prj64NpW7y5Sy6bGRg0W3nHeAndunVpEx8p0Ll/5yPA==
X-Received: by 2002:a17:906:d97a:: with SMTP id rp26mr15026088ejb.251.1570232875442;
        Fri, 04 Oct 2019 16:47:55 -0700 (PDT)
Received: from avx2 ([46.53.250.131])
        by smtp.gmail.com with ESMTPSA id f6sm1447871edr.12.2019.10.04.16.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 16:47:54 -0700 (PDT)
Date:   Sat, 5 Oct 2019 02:47:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: shuffle "struct pde_opener"
Message-ID: <20191004234753.GB30246@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

List iteration takes more code than anything else which means embedded
list_head should be the first element of the structure.

Space savings:

	add/remove: 0/0 grow/shrink: 0/4 up/down: 0/-18 (-18)
	Function                                     old     new   delta
	close_pdeo                                   228     227      -1
	proc_reg_release                              86      82      -4
	proc_entry_rundown                           143     139      -4
	proc_reg_open                                298     289      -9

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/internal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -197,8 +197,8 @@ extern ssize_t proc_simple_write(struct file *, const char __user *, size_t, lof
  * inode.c
  */
 struct pde_opener {
-	struct file *file;
 	struct list_head lh;
+	struct file *file;
 	bool closing;
 	struct completion *c;
 } __randomize_layout;

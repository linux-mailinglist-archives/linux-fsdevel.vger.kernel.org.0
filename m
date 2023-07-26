Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0164B7627C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 02:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjGZAao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 20:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGZAam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 20:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4684426BE;
        Tue, 25 Jul 2023 17:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F22C619BA;
        Wed, 26 Jul 2023 00:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D78C433C8;
        Wed, 26 Jul 2023 00:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690331438;
        bh=HwRJf2zxAV2y30LZeuhROoAoaYKeWsk0jz6e4I2TDSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O/Ew3KvC2OYxWejrYo1gr0rQQ3g5uQPthHMWNklJWVnh5zoMPVe9NzCIdZwAQXmLf
         +1A+Di9DS6TD36yOmgISCSfAjdrPLh2TO7Gbf1llPGWTo3i3KCDRMNpz0eJEW06PkR
         PILqC53xtrFUkEZcCYmGEATmmHWo2vsJnwIEiJQWQZ8e39JEEtVOjgEdF788hEV7y6
         LbY+o2nfE+LCSAt0m1hkH+uxNWGQuJzg87s9AuaxvDlkX5mUpfPQUchBaBrAbCjAd9
         vjYoJAQjDlA/IbWCElcdUES1bgjq+sK/7YXbIMhgjI05BqtIe16+S+ZTjck/dNyHVE
         3UZ8A2gLfr8dw==
Date:   Tue, 25 Jul 2023 17:30:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Gal Pressman <gal@nvidia.com>, ranro@nvidia.com,
        samiram@nvidia.com, drort@nvidia.com,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
Message-ID: <20230725173036.442ba8ba@kernel.org>
In-Reply-To: <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
References: <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
        <4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
        <20230522121125.2595254-1-dhowells@redhat.com>
        <20230522121125.2595254-9-dhowells@redhat.com>
        <2267272.1686150217@warthog.procyon.org.uk>
        <5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
        <776549.1687167344@warthog.procyon.org.uk>
        <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
        <20230630102143.7deffc30@kernel.org>
        <f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
        <20230705091914.5bee12f8@kernel.org>
        <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 23 Jul 2023 09:35:56 +0300 Tariq Toukan wrote:
> Hi Jakub, David,
> 
> We repro the issue on the server side using this client command:
> $ wrk -b2.2.2.2 -t4 -c1000 -d5 --timeout 5s 
> https://2.2.2.3:20443/256000b.img
> 
> Port 20443 is configured with:
>      ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256;
>      sendfile    off;
> 
> 
> Important:
> 1. Couldn't repro with files smaller than 40KB.
> 2. Couldn't repro with "sendfile    on;"
> 
> In addition, we collected the vmcore (forced by panic_on_warn), it can 
> be downloaded from here:
> https://drive.google.com/file/d/1Fi2dzgq6k2hb2L_kwyntRjfLF6_RmbxB/view?usp=sharing

This has no symbols :(

There is a small bug in this commit, we should always set SPLICE.
But I don't see how that'd cause the warning you're seeing.
Does your build have CONFIG_DEBUG_VM enabled?

-->8-------------------------

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 25 Jul 2023 17:03:25 -0700
Subject: net: tls: set MSG_SPLICE_PAGES consistently

We used to change the flags for the last segment, because
non-last segments had the MSG_SENDPAGE_NOTLAST flag set.
That flag is no longer a thing so remove the setting.

Since flags most likely don't have MSG_SPLICE_PAGES set
this avoids passing parts of the sg as splice and parts
as non-splice.

... tags ...
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b6896126bb92..4a8ee2f6badb 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -139,9 +139,6 @@ int tls_push_sg(struct sock *sk,
 
 	ctx->splicing_pages = true;
 	while (1) {
-		if (sg_is_last(sg))
-			msg.msg_flags = flags;
-
 		/* is sending application-limited? */
 		tcp_rate_check_app_limited(sk);
 		p = sg_page(sg);
-- 
2.41.0


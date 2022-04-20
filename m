Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FC9507D79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 02:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347811AbiDTAPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 20:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiDTAPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:15:35 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F4111168;
        Tue, 19 Apr 2022 17:12:51 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id x20so233009qvl.10;
        Tue, 19 Apr 2022 17:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+kZ8fsQMxa2G5tR/zWDa2wKSXSj5woL4fX7zC3ln+ug=;
        b=OWrrgdJJgG5OOmpoVOK+m7hnGruCyhof13q3Wdclz86DnV5uhieIWUtQacHyVpr5i/
         Pja/HaaFgIyNPkuH8P2a5iKEse9Dt6T7So2XS3vHxyZi/0x4QtTXLo7PmNi+tQrp4lsM
         YykNUGfHwc+aECSmtx1pga0PWj0+OBK0KXW501WwC+hsMXmtvyXu85P4zIBspF+bC0mX
         AttBw4tTaxFyB4r5YP6JtnsKJpGd8OSzLOZi0RVSvMyNwFvZ2pA0kY9XEyHvhUMK5iZm
         qqvJeyN/b9p9y/a8AviA6wqpcIWCSmSdqrHaI5ubslaDYIAzSn1ipGb5qEUCEOVpl/0V
         yQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+kZ8fsQMxa2G5tR/zWDa2wKSXSj5woL4fX7zC3ln+ug=;
        b=ae9uWugd7n6a8SPjPSGQ8ifNsMgR+iz4ATC5KhL3op35s/HykjrG2G9gjy+SXroB/v
         A1m6MlxEaFwOIwKok5ciEc9Aj8KuiEWIJktMzKYPDwi/qzCRgm6hogYhjLVviDC08Mre
         EylSxKJU0rlG09J3b6Tyr2Ens4Aea2nKTxsrcHvNUulSuuKQYyTpMJmye1ie4OsN0UVK
         Hsa7YfinfFpFgSYYUM5GubIzfR76y48f3KsSnPqKlejlvLqrb03qwFaHvI1F/U32h7RX
         6/8lvzJBjk/YvFwMx1lHNUxfZFHErztLq8LpCXAMfUjLrM4rPSvSj/AZsAme8E/7ZJhF
         4Hzw==
X-Gm-Message-State: AOAM5326u19dKTxLf07lIUgnZvVP2+hYb3ssQH2hEI3JDNWi+yfNhOyl
        nv8OdZ4PvFH0y3ysRc5IG3hdeN9TcyjN
X-Google-Smtp-Source: ABdhPJy0xATPQzogWwq9m+v+V1IUbI4cTaytqPhueLSR+e3gB8k3SxrBUTaT8oGvP/vU1CPQ4H0yUg==
X-Received: by 2002:a05:6214:23ce:b0:441:8296:a11e with SMTP id hr14-20020a05621423ce00b004418296a11emr13432542qvb.16.1650413570709;
        Tue, 19 Apr 2022 17:12:50 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 15-20020ac8594f000000b002f200ea2518sm960364qtz.59.2022.04.19.17.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 17:12:49 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:12:47 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 1/4] lib/printbuf: New data structure for heap-allocated
 strings
Message-ID: <20220420001247.h2rfftdjivkepre6@moria.home.lan>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-2-kent.overstreet@gmail.com>
 <Yl8llyIN0vorOu/i@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl8llyIN0vorOu/i@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:11:51PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 19, 2022 at 04:31:59PM -0400, Kent Overstreet wrote:
> > +static const char si_units[] = "?kMGTPEZY";
> > +
> > +void pr_human_readable_u64(struct printbuf *buf, u64 v)
> 
> The person who wrote string_get_size() spent a lot more time thinking
> about corner-cases than you did ;-)

Didn't know about that until today :)

Just commited this:

commit 3cf1cb86ee4c4a7e75bcd52082ba0df1c436d692
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Tue Apr 19 17:29:43 2022 -0400

    lib/printbuf: Switch to string_get_size()
    
    Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
index 84a271446d..2d23506114 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -91,11 +91,13 @@ struct printbuf {
 	enum printbuf_units	units:8;
 	u8			atomic;
 	bool			allocation_failure:1;
+	/* SI units (10^3), or 2^10: */
+	enum string_size_units	human_readable_units:1;
 	u8			tabstop;
 	u8			tabstops[4];
 };
 
-#define PRINTBUF ((struct printbuf) { NULL })
+#define PRINTBUF ((struct printbuf) { .human_readable_units = STRING_UNITS_2 })
 
 /**
  * printbuf_exit - exit a printbuf, freeing memory it owns and poisoning it
diff --git a/lib/printbuf.c b/lib/printbuf.c
index a9d5dff81e..ecbce6670f 100644
--- a/lib/printbuf.c
+++ b/lib/printbuf.c
@@ -10,6 +10,7 @@
 
 #include <linux/log2.h>
 #include <linux/printbuf.h>
+#include <linux/string_helpers.h>
 
 static inline size_t printbuf_remaining(struct printbuf *buf)
 {
@@ -144,27 +145,11 @@ void pr_tab_rjust(struct printbuf *buf)
 }
 EXPORT_SYMBOL(pr_tab_rjust);
 
-static const char si_units[] = "?kMGTPEZY";
-
 void pr_human_readable_u64(struct printbuf *buf, u64 v)
 {
-	int u, t = 0;
-
-	for (u = 0; v >= 1024; u++) {
-		t = v & ~(~0U << 10);
-		v >>= 10;
-	}
-
-	pr_buf(buf, "%llu", v);
-
-	/*
-	 * 103 is magic: t is in the range [-1023, 1023] and we want
-	 * to turn it into [-9, 9]
-	 */
-	if (u && t && v < 100 && v > -100)
-		pr_buf(buf, ".%i", t / 103);
-	if (u)
-		pr_char(buf, si_units[u]);
+	printbuf_realloc(buf, 10);
+	string_get_size(v, 1, buf->human_readable_units, buf->buf + buf->pos,
+			printbuf_remaining(buf));
 }
 EXPORT_SYMBOL(pr_human_readable_u64);
 

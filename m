Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C584197C14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgC3Mhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 08:37:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38300 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgC3MhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so21397544wrv.5;
        Mon, 30 Mar 2020 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+5h5Vnp00pGHAWFpA0rxHse7kQHumkG3UT/lUs7Gqbk=;
        b=TjkZfDHhe89sx/aPLzWq0sDiRtZZyhlNFb25tEjcfJtlLxqgtLrNaMwhI31AaYe+Do
         aIfkPxyO48Ms+L4rC89nYVLiqnsGU66cVVUJoilDRRAEF2v0F8/3gdUkTRXRbLYfp5oD
         6k4K5JM+qtiajl40O2YHwHVUMFfoTjY2ECDiSc2zM4UNSboQmDSPlUJbFVNypMAkUSEg
         Mz2p7v/x4dlsG2iOw0MPi/JcXR+ss9hQLmQJWEW/kQ6dhGaHO8Ae4YSsLZEd71SpNqA8
         xKdFk6fnmIuFw4aUSJUwtwdX0UQBY5UylAWfub7MnN3ogmsez8VR3CcBG+HL+SJTbsI8
         fOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+5h5Vnp00pGHAWFpA0rxHse7kQHumkG3UT/lUs7Gqbk=;
        b=moPziA25J8HCHOBxC3CBXHZX1mC6IgENrZ/9iRV4puOVlzCERXGpc/fVoi+EWO+1pM
         6zBnWq4UQ1C0AgpDFI3/9Bz/uWh3RUn1F8DOPnOXNPnrvVC6iz3GbFYhoRh6a6i5txFQ
         /kd2PPcOWLB5l0k9Hwj+iOjI1LGHMnNPrMyjWmx/MtJCIKP2leJAUz0HaXC6SvZI7461
         J0NNNq/hokNRMzJ2Ke7facZpP04quUvP4ATMrdfzUroiTr1gxX5h7Qr2jqdYo8ChVwXU
         xGPh40orGxhHVcZUM6Y7fs9oQXubvstEzRzb0kSTSHZ1+9ubqnUXK8AYEgB2jxOIw03Q
         +ETA==
X-Gm-Message-State: ANhLgQ0pmLp183RsaN33R53ThYy/owD2t4wWsyX5viU4iVceY55CSPtH
        Ne6jL/cz6M10TNMt0msJ6XWyu32v
X-Google-Smtp-Source: ADFU+vvLM4vRWPckeHGmsFeliBH3sfO9hRwleuvO4KwtgKyFi3cmgAx5JHgioT53pz+XP6AVkcAcmQ==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr14345313wrw.242.1585571831552;
        Mon, 30 Mar 2020 05:37:11 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c18sm22239966wrx.5.2020.03.30.05.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:37:11 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/9] XArray: simplify the calculation of shift
Date:   Mon, 30 Mar 2020 12:36:36 +0000
Message-Id: <20200330123643.17120-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330123643.17120-1-richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When head is NULL, shift is calculated from max. Currently we use a loop
to detect how many XA_CHUNK_SHIFT is need to cover max.

To achieve this, we can get number of bits max expands and round it up
to XA_CHUNK_SHIFT.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/xarray.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 1d9fab7db8da..6454cf3f5b4c 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -560,11 +560,7 @@ static int xas_expand(struct xa_state *xas, void *head)
 	unsigned long max = xas_max(xas);
 
 	if (!head) {
-		if (max == 0)
-			return 0;
-		while ((max >> shift) >= XA_CHUNK_SIZE)
-			shift += XA_CHUNK_SHIFT;
-		return shift + XA_CHUNK_SHIFT;
+		return roundup(fls_long(max), XA_CHUNK_SHIFT);
 	} else if (xa_is_node(head)) {
 		node = xa_to_node(head);
 		shift = node->shift + XA_CHUNK_SHIFT;
-- 
2.23.0


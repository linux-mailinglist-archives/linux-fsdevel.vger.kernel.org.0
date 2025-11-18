Return-Path: <linux-fsdevel+bounces-68903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 362BDC68065
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7803382D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E02E301485;
	Tue, 18 Nov 2025 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyGqiam/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E7285041
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451226; cv=none; b=ZPHvTh0D48D/C+7xgEyfr8F7WH7LeMEqgjXl54kz0y3/jvt1OlVyBsl4MR6XmAYHY1Ep3XzchEXhFTeiGPZqBt+4NHz/Ii7M9AkMTR76OSSH75OMTzi56zd3oouABJ8SYkfCxGjlPfvgTOji+XhMxqTPYU1AiGf0DfSESCInogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451226; c=relaxed/simple;
	bh=6rXdHQg9ze9ediLzrRXt5UrfKim/4kp7SpecXWP1YWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awiRBxY0QyLbJDZ/HflLXV4GNPftcsyMzmSDGEAZFoxvVo9ZCBfShb+dzjFRY7biyhWdRKPfDMyzDqZYpDS9U5wdFhI5NMnuOI2zGTgQbigPj2o86ggsxOIvAt2aZJ/lBh3nQKxgh7MfYlR1FnP2tcxj7Ouj/+miJW4i33zwr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyGqiam/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-343806688c5so5487730a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 23:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763451224; x=1764056024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4pnLR3nYW6QGs+3pU2XWgQsECafmapQflr6IKYt1dk=;
        b=LyGqiam/02TlBUFtIvXuhBHXnDJ4ZVIg0brCodQ4dz3I9qO9Wuo9MhINccPvjXGMu2
         w0gDAVOp8IOPRNaNThyjZqCPZZfc0M4J+GqMDL7wpuKDxqkmXZqT0J41oc3yg8Y3a3wq
         MPtETmPQvEtwr4EJFqdmeZBIuCH8jmJg95upQprJ6XI7em/fzorAJbjZA8gmeT4Vp16T
         Z+YiDVdN7TpZdvNgu6psEaJN2IpseQRwEd3E3Z5XWtSP24cyJ+iXWc1+gO6SaLpyrW3e
         +7EWgXH9b8BX5g2w7axt9daPN8t57SSV8+rKkCiBPNy2SHgQ+gh7CyOdBCR4trsTjoER
         voTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451224; x=1764056024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4pnLR3nYW6QGs+3pU2XWgQsECafmapQflr6IKYt1dk=;
        b=FAzp0lQtSxyslQqBOY7MSzyG1reRR1x7fCUutj7bDHBBy7e1auK6awHejLkLDwECLT
         YE5wLoIsYiubdNVS3ZYGFfy+vApkndHUI+BRbVdI6yz7p4noPjwfLRzw8UZf7U+XPv7J
         rBL19qlmX1Z7BZurtI+aDjm7uJ1YSdvCiDfkfqWaIhr2GHxtI5+Q/g7YORMu5iRZjWFD
         UmwBOupI7w1NBXf8imRMu0B1/mMLuE073hDstYEdRAPNfeQSwd7aJmeCsUw762uVaah0
         672uO+6H6hTDY+CCjg2tFwAcHCJA0sN799fqQWQbwXTTrF8ByNeVK3ATHTW8XYftOdxz
         x1lg==
X-Gm-Message-State: AOJu0YwISYa9kpcFXDvK2E09Wlkwvtkt124np7sOPX99T6guYOYZXQKn
	+IDahT//Wdpxv385YA5EKdwp/MNn08Jw/W1r0ZwPwsHACoFOeUyj7P/sX74ax2+NXJY=
X-Gm-Gg: ASbGncs+IprBnEiEOYvY5JrugGT6D/qNoh1M1nHLiQshI4DkNOclNsTTT6fkhUkE/dW
	t31wZdtkIdWBW5P4shXpvULUlGF5PtKA9kApdl9MAdVoev0c7McT2OlOLrN5wmCUFYQUolOk+uw
	ulI2BG426tdpi8oWcV4OXo6P8fT115SxTwvEXoMp9LppCCy8Hwix2wZiJV2TPav85OmfcJLDpyj
	cc81vt2AcKAJoYNlRE1KObaQSZru/1C230Kz59B07xXna7Z38gtUSCwavq3T23BigIaS2LCWga2
	PC/FTkTvxC5Gmj/ywMusvZUboe6SQKOnWpAs1fRT22RWW4XrBTwPMNSw5Jk23xngK2BNMFOH62K
	Wnd8bTSL12bACMpxbc5rgW6EIBb9C4U+JX8gueC6FT7VywqFg63gqqrmmc65082yg1dvrcH1Ww1
	v3OIBZNdlCCcnjmg==
X-Google-Smtp-Source: AGHT+IHVuABGQozdiQqN15VvY/x0SNp9fr0+H4wG0RlBHyygoniVVvrN1oDc7mDiXtuap3Kv2le7EA==
X-Received: by 2002:a17:90b:2f08:b0:340:4abf:391d with SMTP id 98e67ed59e1d1-343f9ebb64amr19610619a91.16.1763451223823;
        Mon, 17 Nov 2025 23:33:43 -0800 (PST)
Received: from 84acb1020363.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b053038fsm623686a91.14.2025.11.17.23.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:33:43 -0800 (PST)
From: Jiaming Zhang <r772577952@gmail.com>
To: linkinjeon@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	sj1557.seo@samsung.com,
	syzkaller@googlegroups.com,
	yuezhang.mo@sony.com
Subject: [PATCH 0/1] exfat: fix divide error in exfat_allocate_bitmap()
Date: Tue, 18 Nov 2025 15:33:37 +0800
Message-Id: <20251118073338.576334-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKYAXd-eqH0HW_=bvTBx+ETtLO505ELRNMcjnUtFgq4waAMEVQ@mail.gmail.com>
References: <CAKYAXd-eqH0HW_=bvTBx+ETtLO505ELRNMcjnUtFgq4waAMEVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namjae,

Thank you for your suggestions! I have created a patch, please let me
know if any change is needed.

Best regards,
Jiaming Zhang

Jiaming Zhang (1):
  exfat: fix divide error in exfat_allocate_bitmap()

 fs/exfat/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1



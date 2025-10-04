Return-Path: <linux-fsdevel+bounces-63424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F8BB87C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 03:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EA019E10FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D049175D53;
	Sat,  4 Oct 2025 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5076c2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E278C11
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Oct 2025 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759541704; cv=none; b=jfcjpQSFPh7OyvyCfxAZfxEWk1rbPxTd87jwQwnH+o0ASk/Y8wwVf2MwKyK/zMt4R9/endZh4BBPFiCFEprAiNAN7mUdkqC0620xJK/3BD8FAQUEvfKTZJREw3d7fYK8DgWBeuSNAjHXo6/mRYSwY6f9R6lxUTFtkUFWjzgLAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759541704; c=relaxed/simple;
	bh=/X0V33VDiMRdzcsd9xCnRB+qtbDJsOoCsmyTwGkXd38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IelN0fdoAUO3BER4KmZp13AltEcO/1ZQxWnmb79k5uqP77P2EZUChALXH8rg0KjR6YeJQz48v+5z+/cE249gMrZEweIH35DwKLbjm0RdQxBv9bhpYqQBeN+P0viaWTq7ThSPNKFH80HqiMeAO0J8FEeuZtBpNWNpUTr7tahtMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5076c2p; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3352018e051so3543148a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 18:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759541703; x=1760146503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGIfLpa2Q+QL0lXCBixwDO1WfArX78dB7nRpjLwydus=;
        b=W5076c2peZjjJnKZLFAVXuTBgDjiSeRNg+98pozIygBrGjql+ZCHrpEFqwUBNwzpZm
         MggUIt8uQ3Mjh2Ed6Eb5bqaKWmMwXnelyQxOPrVdGtC1i2xL0lh7Xc7fBT9T4CuR/RVs
         hJkXFHKzUugLPKaGhYy/FWFtVNXNSqCsJo4q0YKPuk6a6OJGqsbhvgjm92wZbmhsV1eO
         ubNax9CSbwnbMDvWXGCe8fDsrwgo9N4ZrZ9RZAd8rQ9llx+lTOcxG1FIvo1QKATPu5rq
         QqrC52tXA+/rSqFaVTwjCRPLCzsusKs2ey5hjCqwpMl3VP1MiCvUzDk1TXTjStowfpyP
         /zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759541703; x=1760146503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGIfLpa2Q+QL0lXCBixwDO1WfArX78dB7nRpjLwydus=;
        b=stpbef5b6OMfBLimq/mn3GEC/VFNiNcWipbIQLBUdNk1rQ8LPkwgWT3OYOqEumK2Lq
         P/BhuDHc7pmdJaiEa8eOIswRgp/HUOyUhZwBs1Nur9XBZFvBUBoUtHkIN2T21kqBybRs
         wqtKZUbofph2d19JaxApK+J6G8rG87J+Ada4FmGiCXFUbY3/ZM96CY5Mf+VG2TVNFvkW
         6s4UFIFZaktcVD21Y46BipkEcctxNyPye4OhgCpx14YRR3lb3j8wPFaosxp68RqeEc1w
         bOo7c4VZt1ddDRzGZ9KxMYsrj/iNCk6r3EciBxpmpbOGbKa2CYwBBJSZhGM2dTfnV0bq
         CcZA==
X-Gm-Message-State: AOJu0YxdpStjpjy+ZaBvf0ViXT5bcMW/kmfvq8ZiorcUJI1DDNVXk4S0
	9gKdPYQ0b1PWg9tjk88Br0v+5RwdLUlFYG6EPNH+enaNi9U2rK9l12Fv
X-Gm-Gg: ASbGnct/6ZdtrTiTxEsTX1fsDAf5pqQ1lF3twLpRNVYL+2O0zD+sltKbkzvKRzNchj1
	HQJb0vEYEL7sqSh1eQy1fgHLcOpWlko2l+b9slWr8b9e9492A8gHy375JvwtTns3JVpoixpJpOd
	Hm+q7mrPUaIm9S4lc3iRLZQMgiwQbLO3XRzW0F4tBLrxRnoPHyAQDSrzjMY39DdEn9xlUfCNmpQ
	U3lSmh74kdpTeZKhiz4chChnSlMN0HzGJT5IUzsG7Ft0aqEHLITioDRQBHhhktlKd3H9sLFu0of
	imHM+ZMrOT54Q59Lz1xqTPHVk4d17d3t+V5b2zNIe98OPH1bQfEUw49rc9czoekP+GRYwS84csh
	cP9s61csH/VS3Vf9HsWRMSsgV0sIxO78YiV+Y6tppsMkTtr5FToviA6hibuVI+L/QRQfKnPTQVy
	krykFUlSTFuZmddhc72qYVxBvBTgyaczv+6LeZ
X-Google-Smtp-Source: AGHT+IEluKCvgWoEGyq4QJ38Wau8hJVOI6ympnHbwypwMOvZncOrazRuT/Kg7dMZuyzHuQxYXNlL2w==
X-Received: by 2002:a17:90b:1c8b:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-339c2707c6bmr6250088a91.8.1759541702729;
        Fri, 03 Oct 2025 18:35:02 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2401:4900:5d47:aa18:a39:a592:bca0:286e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f599a2sm5723647a12.36.2025.10.03.18.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 18:35:02 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] nsfs: handle inode number mismatches gracefully in file handles
Date: Sat,  4 Oct 2025 07:04:52 +0530
Message-ID: <20251004013452.5934-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I wanted to follow up on the v2 patch addressing the nsfs file handle 
validation issue. Jan Kara has provided his Reviewed-by, and Christian 
mentioned plans for future changes with the unified nstree work.

Could you please let me know the status of this patch? Is there anything 
else needed from my side for it to be considered for merging?

Thanks for your time and feedback.

Best regards,
Deepanshu


Return-Path: <linux-fsdevel+bounces-47936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D582BAA76D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 18:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AB898649B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F325D53A;
	Fri,  2 May 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGrcrF7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD4259493;
	Fri,  2 May 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202294; cv=none; b=OmH5jrrhSR4V7c4CsW/wB5Zm3EdcHiMywteGOrJi41jXyvtKzx8v4ncL4E2YBRnDJOOZ5rH5EyDDMQvZ6+qd28IR63i72TaZV22duOqQS46sVpqck5sppIQKDpYtkwMSjfwpvw+K5sBE8jaUq6aA8jkDL2y6EQND61Dhh35IvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202294; c=relaxed/simple;
	bh=FpRpQtjRv7U53wWwY4VCfXb19CcJoypmcqGSPRHC3Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bh7iqmNsNxdkgCPv5/YJ5mkJjGDcem78vnKBu06UY+T5YQy1GVo0PpgwlqCvuPWIEOD8En+Q0O4aUTY8bkkvXNEEfMaUaTXQN6sE+hP/hi21+VybQ50O7OlrSC8qX/3H2DU5Bpk9bpRFopQ5IYwgez5VX5QDlGRtJuUvr7bXQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGrcrF7s; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47ae894e9b7so46563011cf.3;
        Fri, 02 May 2025 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746202290; x=1746807090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FpRpQtjRv7U53wWwY4VCfXb19CcJoypmcqGSPRHC3Kk=;
        b=RGrcrF7s7iE62EdF+HkUMRTYkD846Z+8yAvWmvXfVajSAoZOHqrgcrBZjv8+n8fh/g
         PDX7uhWx2LTsIjLY/KV0OJ8nbnAaNuVin/vl2PiP/pdSK8my5eCZore0j81aRJ3/wPW/
         qESfpGUYLA3hUSiva2y+qqKNSoVn3uJVbKNeHn+7YhX7Ua8CMiZKTRcuZO/Gsc49OzQS
         12buoRE45OQd2TMswySbJ9phCxpgznCihI/TokBkOLgeBz3wE6mIKiNlR+LG35Goi0I6
         xojgeMtrrf8KKSvpunq78Ktm4cys/AiUdQ4CxBs3ETTqf1itMGiaMqXpN6lZpYxi6ikN
         xb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202290; x=1746807090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpRpQtjRv7U53wWwY4VCfXb19CcJoypmcqGSPRHC3Kk=;
        b=mrTc7WJqD1Zk5jBCoOnmJUN/EnbFNESley0FpEzkv6zt3OXtCJPTRM+Ah+v5Ql5SLE
         ygKWAeZQstc4KiR7n8vshNiU4pBvhdGiBRsBQnn3PKTOXoBmLMC/VMmsaT+HuwGWHie5
         2n72hKy+gzLiCjV3ezguxyPD4Fb2srbDWe/euw/7Z1z6PsMh1zDKAJW/soH+pmMp53wD
         MIt6aDABG8xhAN0MZ0FVz12XRCgpukP6cFYBNTzq689gfmaO549LNdu6K9AqVO9WmZIl
         P9pNsAYxxkWs+fetgNS8JRjM9BduVXboQE7SA7jWhup0fHF8g+bv1s2HIXlHYsGqTJJA
         WxUw==
X-Forwarded-Encrypted: i=1; AJvYcCWcTiYamfUdn2PubF/3NE7h3B5BN4FquVi52eaoIa94n21JoHE69zX8epp2RCGyj/JpWohmCR45k91PmiZc@vger.kernel.org, AJvYcCXUK1HcpiOoDW+hu1los4KjsVWCVlivQOKY6LLwZWjiAFdPnps6T3HDfOJbpPKoRDP+L12ogR0+Rx/6KA6b@vger.kernel.org
X-Gm-Message-State: AOJu0YwdV1Ofj9E/vKahmDeYWX9DQssd78/rFBLeAB9KJ54jkSZ6q1f8
	WRSoRwWYbZBztV1sXEPtQZqzLewrhcdRNOkGV6WbnZsJQS7R5HzDmt+GvaHqXrmmXo9BuVHgQsL
	akDZcJh7CtSqQU7NyR3YTTUlTmGdt53HiVKxLrVvsRnc=
X-Gm-Gg: ASbGncsmGFF0IEH/zFxsoqHwf205U3H0JHzMpPRe0yGDnSj4s6aQDdUnLpgt9iv2/vK
	2fH1Iy8ral8DktSSUgKV5TywuQCl6URpRdp8xXpHdrygfW/GwJzYhxIMs4rzqdFhhIbUmu/4G5d
	SKbrGUpnXq7cKDfbJ3kX5U9Y7Uv2ixI2UunQ==
X-Google-Smtp-Source: AGHT+IGLAcTSARnmJA/Kgr6uTJWmezvLkJPX2YxhNgDW8SpYetDoGiXPi6v2yrZw/2G0zMAf9dBpqWLczPRdekeeSmE=
X-Received: by 2002:a05:622a:1b10:b0:476:60a1:3115 with SMTP id
 d75a77b69052e-48c32dbeb1amr57251421cf.33.1746202290456; Fri, 02 May 2025
 09:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502153742.598-1-zhiyuzhang999@gmail.com> <a3a6443f-2351-4e55-a12e-4d1f28ba7ca4@oracle.com>
In-Reply-To: <a3a6443f-2351-4e55-a12e-4d1f28ba7ca4@oracle.com>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Sat, 3 May 2025 00:11:19 +0800
X-Gm-Features: ATxdqUE7NpAQl6AyGoPFkOH6K2jeAL22Fq0V5d4sv1gugCSgZGARFw0ffPFQ0bI
Message-ID: <CALf2hKsAL=EysQyzgOcztWDLM5X786b9OPPq9sL=oSgamZPjcQ@mail.gmail.com>
Subject: Re: [External] : [PATCH] ocfs2: Fix potential ERR_PTR dereference in ocfs2_unlock_and_free_folios
To: Mark Tinguely <mark.tinguely@oracle.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	gregkh@linuxfoundation.org, ocfs2-devel@lists.linux.dev, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mark Tinguely,

Thank you for sharing the patch status.

Actually, I reported this bug on March 22nd
(https://lore.kernel.org/linux-fsdevel/CALf2hKtnFskBvmZeigK_=mqq9Vd4TWT+YOXcwfNNt1ydOY=0Yg@mail.gmail.com/T/#u),
but due to not receiving a response from the get_maintainer list and
being quite busy myself, I have not submitted the patch until today.

I am sorry to summit duplicated patch as I do not notice the change in
mainline repo. Please ignore this patch if it boters you.

Best regards,
Zhiyu


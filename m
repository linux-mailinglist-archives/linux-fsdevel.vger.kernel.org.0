Return-Path: <linux-fsdevel+bounces-44786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E65A6C99E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F01A7ACA0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33B1F7586;
	Sat, 22 Mar 2025 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBMf5xXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE81D63F7
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639868; cv=none; b=Z8ySTFARWt1+ANuVmy/Yq2cFgWE+P3/uc/9cOPudnuoxPPVP0ETTE/VLWRfHNsV62Z/DHwMJvq5OAaH6lnrmBjLoHTqq1NwEiTOetTyPU22SCkjtcwEnOzzSYSVeO+6c2Wrpeiyt51iE/Y3ttgphFYPeNc5B4clPLiQ+p7ezb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639868; c=relaxed/simple;
	bh=T1V3deYJN+XdsBG0Xz0EgW9GVdGUN9F/Eziv3WfXZpM=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=ocsChQ+tnS0zUBz0uje6mE256ky83KSy7J+VulO+ZlwPPzAEwRqFg4HL/pJWk20gwtXK5cq0BYvE4DsJxSlWZVKTdQKnE9JgCTOgVZ5Gdnb/etqtJ9N0rmiiJ5yOaRn+D5aIsX2GTdl1K+MaD2aqdx+LTf+BJcAAsDEQAO2kUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBMf5xXI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47677b77725so25605091cf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742639865; x=1743244665; darn=vger.kernel.org;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1V3deYJN+XdsBG0Xz0EgW9GVdGUN9F/Eziv3WfXZpM=;
        b=LBMf5xXIOoKhC/Nn8CEU8KZSHxWhHwsj1/7jocG7mF231ErxFU8nRmnzQ0TbDRYMQX
         h0W0nqkBldSFmn5vZPmuld7XLHDD/YTxurCndkKrvI9BY6BxI/OFyxxE529sWYMjffzr
         6LH71EKmvy2u3u2EoVTBAGvERTTOkpbXdAzNV3Qw0eermpIVzQMJdjvosWyV4qVw/jfx
         /YQXi+OEp31+gQJVNFTg2+bXuUE+mUJAYuo+UtJ21gjQJfyhY48TZZ+iS/+fWUS+88ny
         ldmZpL4k23nvn6BF50rSgYRCxI4KaTv8hosYDvBfPyQidTK2wg64JMfEi0Nrm/NubNyw
         tfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742639865; x=1743244665;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1V3deYJN+XdsBG0Xz0EgW9GVdGUN9F/Eziv3WfXZpM=;
        b=bKxMCuXL2xOB1yXDBnPbKnjE40plqUhtZdpFitV/JAO3gf+XMelY3l+3Aj1fnF6joq
         Bk0WJvaD0t6HKO3B4fx3AZmvv98c2IM7pOF4YT5N7/G7QTDuOGP8IVBcgwD6MT3RyzJq
         XmCy0xgC2ROZCUpvrU2sVIzbuXs60KTtw9JCeBANpR3G1aOtTkECvARMCMU3ldb4xsEF
         OjDKnmmO5HnfKuIpbK/FWuIJ86ZLVGM/Uvt/N67XWTGWlbae+bFnfNPDU1WMs6SGf4G9
         R0aWR0kDaTcBy6OkFR7q5Xktr7r5G2NXoxvyt8HEouQSyIq13bm1UD/ZTZ4BtEAi2xTW
         ZJDg==
X-Gm-Message-State: AOJu0YzvL7Ny1fTVIqoWppAFMJ6cvwmdeD/KotP2xeNKaHk5e08+vXCE
	2vzHIbE1kgEkDPd6G4GRqjr9iQKgjQlQvwCBXKQBR/dmdc8YqkS2pBzlZ8Zk
X-Gm-Gg: ASbGncsXQkqUi8UxtbOpCDITb3KSXaEy3Ybh97dsbU3J8abR22Yoa1cCzDAM6Ed9EWV
	xugHnlJ746nYsGu/wq09RPxOrEwvi6qLsE6p9X1eNWyLAJ1nbU/qhvOU58jfVdTGABkvxnXpQPB
	e1MUJZefxhA0WzZIXhsVF8VBeSbKQuU143WGi6bYSdvIGIBrsqMIMTgm2iEPlHsNa+t01nygsbh
	DXFyJxcQGckHutLOzrTTl1kIhAOgAnBESCGzfI4l8Hxf1/2gdUK63poGFO76CIG4hGInLv8yllJ
	wLh6AjARbLAmG2TY6J/NgNBeM9zA72BWm33RFip4t8gyN7uF3z4lDSO320SCAuMeiSGHWXliGDW
	4WnWnVk3ApLcuZnB5gvZR4cjkbJ+G4YQ=
X-Google-Smtp-Source: AGHT+IH041XM4ZOTKN4ZFcZllzZjrhaOaUPtCPbHY0Uji1sDiUzl3+fZHw3CaoR6jUOFawLY4vD8hg==
X-Received: by 2002:a05:622a:4813:b0:476:add4:d2b7 with SMTP id d75a77b69052e-4771de91de4mr82856431cf.51.1742639864777;
        Sat, 22 Mar 2025 03:37:44 -0700 (PDT)
Received: from ?IPV6:2600:4040:5f54:aa00:784f:1aa3:18f1:dbb3? ([2600:4040:5f54:aa00:784f:1aa3:18f1:dbb3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d15a097sm22485701cf.3.2025.03.22.03.37.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 03:37:43 -0700 (PDT)
Message-ID: <97f4d75f-b259-4550-bcae-439fe7db302c@gmail.com>
Date: Sat, 22 Mar 2025 06:37:42 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
From: Ric Wheeler <ricwheeler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ricwheeler@gmail.com




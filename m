Return-Path: <linux-fsdevel+bounces-63720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC16BBCBA56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 06:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 809F04E5BA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 04:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA801E25F9;
	Fri, 10 Oct 2025 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdTwPcO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5636B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760071250; cv=none; b=fFsH0ZUc1zSg4HG6dMoOW+9wpM1FMABRuCyxlIwABzo32OWL+/KAiTfRDMIRs4Szax66mt/XQVlUReEa4ezxMDOQiogw0Lm272FIykTFX0eIAcvLx0zp1ZodvAvf+ij1+v7ZlpWRR6xRYED3bwqElFKxsNF+RxiUyEoZ5Yp7B34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760071250; c=relaxed/simple;
	bh=Svrst4sNWvZPM9ptRkVgFgBmuigM6Siiz8w5w3Sqplk=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=dMtb9r6Wqc929MI4VIJbMFV4u9CCHFVhg/2Ivspa8U52AazxphdYm/qtS1uRVjWgivdhGGEspNlWUNpIq0XYWFOLpqs+EanhXAkwUaYUdHFML5l7oZFgYYteoZ+y1Mm2d8ClaZ4j+TXz2QPlKAlNIE1Qc5N0P5nYYFNJAZX31jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdTwPcO0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so1023776a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 21:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760071248; x=1760676048; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzXQ6gKxFAXIJd8vP8znvGajrLDgu7v1EN7Ipv13j7s=;
        b=KdTwPcO0w+s4UW1k/t1P9wePQdX4K6gpgTIotuIPp4V1ZVUrE/1IIvJ0cbtElMgQnM
         CBvKCScdN0rxr4HZcN+eDbn6Imys6c1SqfE49S09h313lD1FmQgwEBAU/fJrauICLbdp
         b7nk6NVAGwOmJkxU0GkG5iwYJJlaT8sXgNeJ0qhFmkudCWhAXRD8NDExY2AavrEsIFT4
         Ko5SmYhDSzmcmFstov3CytH10p4teM4jeyciw+m7KKcJPMSCmBkMy6AIWxmmEBUMaXBw
         TqBDXAn+6l6Xthnjj9e4+CnJrgk7Ssf1iNd7rdTl6Ujst2heuzXQg1fNhBjLR9m4CatV
         HyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760071248; x=1760676048;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzXQ6gKxFAXIJd8vP8znvGajrLDgu7v1EN7Ipv13j7s=;
        b=qYWdfWSFkxeXUBCOMbMV+VN01XLrnDu0dSV1/o1EWF5JVxaPhkGPh31ZcJyUA5urv5
         yFEuzxJtdPQwO3yLX+omd0Vp6jq3480v9sN3ZOYUx7CHUeRzY+mxlg5aDyDBA8h0rbz/
         Nb/F71+CG5mVL9b0CBzRwkQmvjZAh0yeHYyVFWPykvszgmYAnojG/nARGfrakzWouXwE
         7cDFz3fXvHrDecLmp6Km3HtmsSUfugjjaujlPQghHNi+cRksSIiaxSlJqMeNZOyl2OMS
         V3mzVXwPOP8HSZ9GYV9mN6TBx/j/GxXod55FdznAN3jkBnd9/XpGjfFaHc3ZV1gvIVQo
         50+A==
X-Gm-Message-State: AOJu0YwlURmV/88vd8t8ykBZlVabpFL0+/CMi5JWTD7PinQEFAm50rcx
	43gIOWJhNMOUDmYc03jRJElh7J7mnKrTawSzJ6zKvy82gtdHI+jZk8PRq8y+vw==
X-Gm-Gg: ASbGncuQCaLEa/hGsQoX5PzBzGFprsbFZfxO7vey80utMz2Tw3JkcLL7xdSx68YlbBX
	EDHErnTxjBHy8IMO7RfnrLAmYJA5k8XieY/Zb8MIRy+LUpy24zBclzjY1t4ppr77nn6VSPamGkn
	WFGpqylDKYdOASZtQmDX7rsHU12Ag1dlLswR5UCMSk4aM3D8J3JthhvHlCEslX2Rr0aOJe35JxC
	tF/DsiqIGjDDeV/Ble/mQfLMwEHKK8Vei9mTLxL4ILQTI/0EwnKT/QCZWPRJBtU1jo40L+cipuR
	qR+3ai76sUleppJw75q4RPO9YSxVnysRNvhIjcQJMdJE9xX+rwcZCWiGHAzuPlmcDPnZYFgQrl4
	bck3hAuUVIaaN6LOZaYi/W1qGclL5Ri/I91x/A6xYsdm1gPUAeShhPwCQruRb8qrCHifev9j91g
	Q93m+jFaniaDXw558uBq8zXyFMvpeS
X-Google-Smtp-Source: AGHT+IG3Ppp/ioyjHrs4hFoR3m0wnX6lbzvwKITok0xYiHVy4z90x78Qu/UxTRCPWHIUpvBOOIXahQ==
X-Received: by 2002:a05:6a21:3393:b0:32b:83ae:567d with SMTP id adf61e73a8af0-32da812f3b3mr13117956637.21.1760071247817;
        Thu, 09 Oct 2025 21:40:47 -0700 (PDT)
Received: from ?IPv6:2409:40e3:2084:f4c4:99fd:d346:f152:46c7? ([2409:40e3:2084:f4c4:99fd:d346:f152:46c7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678dcbf919sm1169774a12.9.2025.10.09.21.40.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 21:40:47 -0700 (PDT)
From: Vimal Yadav <vy147591@gmail.com>
To: linux-fsdevel@vger.kernel.org
Subject: RE:Appointment request
Message-ID: <bc1ecf60-1178-13aa-1396-e1313c980027@gmail.com>
Date: Fri, 10 Oct 2025 10:10:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB

Hello there,

We did not hear back from you.

Can we schedule a call for Friday (10th october) or Monday (13th 
october) so we
can discuss Artificial Intelligence and Machine Learning requirements
you may have?

Kindly share your contact details and suggest a day/time for our call.

Thanks and regards
Vimal Yadav
Technical Solution Manager


On 28-07-2025 16:17, Vimal Yadav wrote:


Hello there,

Are you exploring ways to streamline operations, reduce costs, or
deliver smarter customer experiences?

We’re offering a free AI readiness consultation to help you identify
opportunities and create a roadmap tailored to your business.

Let’s talk about what AI and ML can actually do for your business.

Look forward to your response.

Thanks and regards
Vimal Yadav
Technical Solution Manager


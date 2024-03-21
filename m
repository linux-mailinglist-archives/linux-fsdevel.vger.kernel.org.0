Return-Path: <linux-fsdevel+bounces-14951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A1881C80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 07:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CA328394B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 06:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADEC3C484;
	Thu, 21 Mar 2024 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2ianOgs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B73BB29
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002733; cv=none; b=fwtEsvFZl0ggoJZTeAL3fkjmEsEXEzGc0a5h+Ri4a76lkpkeqz3APhgrlVo5vpie02kAYMhvgLVfqdTutut2KsChZlMHqpyrugqLspGC4McIW9DTfgfKd/XdBi16Y0npUqlq8u8srR6P7K85euXhNAw9SQ5efpF7MQC1zTV4Rcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002733; c=relaxed/simple;
	bh=IWzoRyiIq34RmhOn0iDV7qym3hPufd8Mn7S0DjBmBYA=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=AWt8BmYIiNEA4XULYDtyWIYhR85CdnbK6LOS/E2Mj2U7ds4leqFLrJn7bMmtjr+pTk0mUl2FC9ZQZmlNW/pumfKNih4sSFs3G0ibID2mY11swxcuzwi7dlt13xS65aRlmvJxkscxJb+wdT8ZCNIg0/VrN3oyNCe3OpAdnlHwX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2ianOgs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0189323b4so4125715ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 23:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711002730; x=1711607530; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUEt2Z97b8lEWwJktqHAAwXS3vj2uI9IohvvSbiYwx0=;
        b=k2ianOgs6XfahY7djovsmCc2HRcRAvOPaJwjG31wpDL5zRkEVzUeUe/8EELufGVrqX
         9XvMSOGFiBwiV7S525r0SditCfH4kNx9Sa8EzKrQFtmPNBvAmzKzECAESyXw7esa5V69
         4f8T1oQWEoY3Fl98u+1qEicop+FESUqLIDUnM1ad6hoR5xBo/kaEhq4k8X8Nm7+c0jjo
         TbjlmzaqwFw3X6asXhefQcCOErMB6Z9sHm7sFKRgF4oUUPz58lCbHXAilwAvs+hqrQ0K
         0PSUi2DoUQDnJgglXz+tidtEgDQ0cg8cu2E+XE3J/wZJkvWMz3t9GzZY2/XRLLzx9zmE
         HZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711002730; x=1711607530;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUEt2Z97b8lEWwJktqHAAwXS3vj2uI9IohvvSbiYwx0=;
        b=DFsxuqlyCMT0YyUFRoBHwm7aqP0ExubUvMHOm5jc11zM/QTNrJDso+ezX0/JQ+cFNG
         UgHfK/Uq/AJ6cVohbkDisR4IgnXnXcXf96KFXMnQFVp1x6I7y8VC4Fjs6XyQ+/BOBOYT
         vAyDV+Pw8QsOlzGMc1zEF9Ki6U+EKRa0gZ0Cs5GAtcwYcAfDlLcij2E1OCSQ81oce9jh
         OLN4MCExU7rd+cPtj5JgV99u8cGSS4z67ru0EHGfQoKgp2H1mYn0OGY759uOZq3GBoM+
         1zd2ZDuhAVFDakaAyH6R2IZXZfSB27LrnszLfY8xemaLKMSUIXNdP06n5o8BufXhZHCz
         /5wg==
X-Gm-Message-State: AOJu0YzUpvWGkq02kWkF09R8GEo1QXiuf2efXoPe/PlXV/+tuOLe0Bn+
	QokftmHygiXnyFNXTyczS4Xb7WIweTcMeqrdeGWOiTPbQ217qF5JaoitMKTz
X-Google-Smtp-Source: AGHT+IGUtJRNLNOl2DMk5FallQXu86jmnIbAbbBmCeEkhh+a/L48PJFWk2XVRdMBYS10t/Zm29L4iQ==
X-Received: by 2002:a17:902:eb45:b0:1dd:96ca:e1ae with SMTP id i5-20020a170902eb4500b001dd96cae1aemr4132733pli.69.1711002730593;
        Wed, 20 Mar 2024 23:32:10 -0700 (PDT)
Received: from ?IPv6:2409:4063:6c85:f395:d58f:6b15:5165:7028? ([2409:4063:6c85:f395:d58f:6b15:5165:7028])
        by smtp.gmail.com with ESMTPSA id jx18-20020a170903139200b001dcc2847655sm14865305plb.176.2024.03.20.23.32.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 23:32:10 -0700 (PDT)
Reply-To: businesssolutionsrocks23@gmail.com
From: Raju Kumar <rajukumarkorav@gmail.com>
To: linux-fsdevel@vger.kernel.org
Subject: RE:Mobile App Development || Web App Development
Message-ID: <e2578063-3dd4-d349-308e-8d84e936b10d@gmail.com>
Date: Thu, 21 Mar 2024 12:02:05 +0530
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

Hi,

Just checking with you if you got a chance to see my previous email.

Please let us know if you have MOBILE APP or WEB APP DEVELOPMENT 
requirements; we can schedule a quick call to discuss further in detail.

Kindly suggest a good time to connect also best number to reach you.

Thank you
Raju Kumar

  On Tuesday 28 November 2023 5:43 PM, Raju Kumar wrote:


Hi,

We are a leading IT & Non-IT Staffing services company.
We design and develop web and mobile applications for our clients 
worldwide, focusing on outstanding user experience.

We help companies leverage technological capabilities by developing 
cutting-edge mobile applications with excellent UX (User Experience) 
across multiple platforms.

iOS App Development
Android App Development
Cross-platform App Development
Web App Development

Can we schedule a quick call with one of senior consultants so we can 
discuss this further in detail?
Please suggest a day and time and also share the best number to reach you.

Thank you
Raju Kumar


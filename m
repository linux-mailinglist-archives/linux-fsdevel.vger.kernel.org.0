Return-Path: <linux-fsdevel+bounces-58077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B00B28E8F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 16:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79055AA6AB0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304DC2F39DF;
	Sat, 16 Aug 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4bEG7Vh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F109A2F39B2;
	Sat, 16 Aug 2025 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355496; cv=none; b=rkLYopVuE1vRsJT6O0arUwu82FuicD5MliGQuKcf9cxv4tqlTOCLql1X+vuxHbIzaFF50iLxk2ypUfcPBp4IVzDMyJmtqFeB+SmvCOWmSeXokGvyJIneK2QOBa6gGa1V5ixTzsyuMhYmYbvLTwsfVYeRWJyDr+902mCxNkCpDS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355496; c=relaxed/simple;
	bh=Ad0rqTBKrC07+KLGJQvOoukB6wwe2MaDDb656sA5fHg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=m5PwsB68AFYl0zgM+cj8w4jOebiw9WQh7wRa2fyyHUfIAwwtpcYrOX43wNKaoqF0aDrwHS+zmpD4YWqm8x45W7gaZMB2QvubrBWN0gZ+qEMZWRzBH5DQ5wxVgrqOuQTpksq6PdTpd39fWJwaRrT9dCaKUNn0I4Vck1OPtyMJc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4bEG7Vh; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55ce5097493so2797873e87.0;
        Sat, 16 Aug 2025 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755355493; x=1755960293; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad0rqTBKrC07+KLGJQvOoukB6wwe2MaDDb656sA5fHg=;
        b=L4bEG7Vhx4m8xNxjog2TobZ9jx0q2GnPAHAyWNEFPtcEJC8zNx42nEh9+wacQRra2L
         LTj3xFCgksFhKm0AATIXrMYAW64FU4GeKhMUv2BNpPz08VHv0rugYoTI7zGOVjsTxO4f
         V3g6CVmQsnrUX5F9KjIoCqwK1dG8Sm1nVmGugyW5FiJ2FTisr7A1jhUczzrjPYl0Om+6
         keJychKWiFf7bwfMZ0nPOf8aLsfV1Z+3xUY9FXj2uELRkaLqlPn40DBDMbIivPmSREjB
         GIT0JQ9GZWS4RmQmE8vuZteFYsfJZl7uNFb/9LXYo2T6qlrFgAKH/DMkJIPV7lzmj66A
         7f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755355493; x=1755960293;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ad0rqTBKrC07+KLGJQvOoukB6wwe2MaDDb656sA5fHg=;
        b=rdyOeccNlgIIzjI3S5F7pnZ1cYEYrV/GvNifEiDLJhVlVPpyLDCqAYvj2DrazON0xo
         fhFMTa9pwTO6ohCaG6EZOY3c0Xf6hka/Ec93N2cXc1iUQF/n1kEnlKY/V4JGcN/Lhn3Q
         qp886BQQRxdMPg6WDxUNwrBeaCRnXCK3W3w8hJH+ufnpKY1nySU1RnsPMi54+NlPEElu
         Tu8Yxh2fhBEl+eztTrd52K8rLS6cGfk0zEbV5pXbCuMnrQNumRvZ2OCGdzUoJHWRr6zV
         FRdLo8S0aBzJr12V5dCcM2ym6jwWa9n1EJbTLOETsrTPXno45tsBbx4MLytYex63eQSw
         x0MA==
X-Gm-Message-State: AOJu0YygqezPGHNycic9qpphKJBFTgNNuszgUj1tLK07t1O22RExu3uW
	Mjwgr11p36cFHxEEIyF+jHKCuPQNFeEMshusHR6Tp3W5T9yHGIKRGRD8g2gx8g==
X-Gm-Gg: ASbGnctrMlpzSg/pbdgUa4Y1gnj0akAHt/P0pS1vRyx3QAlHDBggOYhPANsKDX2YFGd
	qYdyReHPYZW6jL+ARRDKRF/o40AIDJQiqjJdag7kF3gKkdwdOoJmu/Abz8qMRRhj7OBzIeHoh7p
	KehwFYdVG/JzF+jzpjOAvbwWwtXlriLucvHs53ktaR/i9uQw0TaMHGtj8UoJW1iKaPcoYLy/9Zy
	YgirKtxIFXR6/20SKmKr+MkzjaLPQwWO3JdQJn6My04a8wZhbcA4XvOfJrfltOsD92C1CGe53o5
	0Z1TDmvnxvnl0IAW961axuVsXZq98BimTS6AUIIktN6H2cU8Y1Sd+72zZkbNEPWFDznDnUoeacu
	B8EjMh66x1+AJwCmnbNV8PACTkQmp2bWo6G0tDf6q86ulbUT/PIdKwTDx5PNVtOPxodyxlnsQL+
	GQai3fst23mU0UQ8ag5LHL34Z9
X-Google-Smtp-Source: AGHT+IHFziVeSKf3pFW9oNtzz07cnSMCtCUhRlcd67X/iT7qKpqZQJWJuSLgmtztlQ4qh6kKS6K6yA==
X-Received: by 2002:a05:6512:620c:b0:55b:8f02:c9ee with SMTP id 2adb3069b0e04-55ceeba008amr1280651e87.55.1755355492622;
        Sat, 16 Aug 2025 07:44:52 -0700 (PDT)
Received: from [85.229.209.79] (c-85-229-209-79.bbcust.telenor.se. [85.229.209.79])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f3568sm868489e87.117.2025.08.16.07.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 07:44:52 -0700 (PDT)
Message-ID: <d38f7ae8-d10e-428d-b72f-a1fb490a45ab@gmail.com>
Date: Sat, 16 Aug 2025 16:44:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-fsdevel@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: Is it normal for the user and sys times in /proc/stat to move
 backwards with NO_HZ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have noticed that some of the values in /proc/stat, such as user, nice, and sys time,
can decrease on subsequent reads. The file Documentation/filesystems/proc.rst states:
"The value of iowait field in /proc/stat will decrease in certain conditions".
Since the documentation specifically mentions iowait I assume that the other values
should not decrease.

A simple way to test this is by running:
while true; do grep -F "cpu1 " /proc/stat;done| awk 'NR>1{diff=$2-p;if(diff<0)print diff}{p=$2}'

I believe this issue is related to the use of NO_HZ. I use nohz_full=1-23 on an
Intel i7-13700K CPU with 24 logical cores. I have never seen decreasing values on cpu0,
which is the housekeeping CPU with ticks always enabled. I have seen decreasing user,
nice, and sys times on all other cores on kernel 6.12.38 and an older 6.1.140 kernel.

I boot the kernel with the following arguments:
nohz_full=1-23 rcu_nocbs=1-23 intel_iommu=on kvm.ignore_msrs=1 kvm-intel.nested=0
kvm.report_ignored_msrs=0 vfio-pci.disable_vga=1 split_lock_detect=off

If this is expected behaviour it would be helpful if the documentation could be updated
to better clarify this.

/Thomas Lindroth


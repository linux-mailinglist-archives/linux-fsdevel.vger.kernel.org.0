Return-Path: <linux-fsdevel+bounces-22815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6991CE46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 19:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DB21F21B7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E3481AD2;
	Sat, 29 Jun 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMx52y9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC144D8A9
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719682224; cv=none; b=GC8ypvEBTGS4yih6EjzwIedtenZIGLRet101pXRm3cnv2KpPJxGsfz0iVlN10Znxx0M06F3+C2QYoyOLW7zGUncA1CmGCDSDFqucYu95yHKdvDwZAykFsf/iwYOwib6wEiD/9MjnasrCV9cUIkla1yBAYXYjSZez4R7ICgDUX54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719682224; c=relaxed/simple;
	bh=0Hk9hhGTxn9mUzggbFcgDx/2rBK10MtYVCrt8qOwshM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gUxL6pG1PtUFpJUMLmy80KTxsX2CYoFgveQ9v5eZNHoH8xupLLlpmKzHqKFZrZidlfKDq9tioWTniHLQ+hOWcWpW3G1lbHwSRFpJLckjzKMbWU0jP96sInVYalk29QjQAdT2m79bbQD79lWyTXvsFppHRMrFAxfmMJ7CqWFoV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMx52y9w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719682221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iF002QLgEO5tZviF+GAv2jgU58wxLE7FABlj3pE0mcw=;
	b=SMx52y9wAB98hFQPe95RCFc85aoOdiTpmdtwGVFX4VYl0esO815mNsUbf+AXRgQImmbusn
	PDzZah2Y+AizPokTjAv/ilTJ1TesoxvrlaloBKbb2P84gI7lpclp0GgG74SGDt2iKCuR95
	D/VUUT67O+Up+l4ZaVSfnD9JDYBSCpk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-4Sr5uzwWOEydpknFUlDPxQ-1; Sat, 29 Jun 2024 13:30:20 -0400
X-MC-Unique: 4Sr5uzwWOEydpknFUlDPxQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3c9711ce9so165786839f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2024 10:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719682219; x=1720287019;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iF002QLgEO5tZviF+GAv2jgU58wxLE7FABlj3pE0mcw=;
        b=w+i2qRWnvZcsaBZnfnhmpHxrnNy1jwKOnjwq/gB2oU0eSgokjh8qmMZ7Nz4YMf/NMS
         dXPirzG1wC0o+qwFcYfIYsS5L0ABiYcdsAAXms+l82ZnKt5XWV/PyJ9Vd+DLaaI8YqYY
         jpbTI6wYf0ezEODgLIOfusJ9I3RhjMPxyqGJBUAhFRwDfdY2MF6xnR0wjkpD5YRGaXqG
         vbuHjP3/pmckPWLgjz16202C9tF3yS5vlpUhDGxd8Xdd0igkQMCDza3GZIguHyqi5n1A
         WjD4arrV/6HwGPLBoJjAA4sNaWDCtVS3s32CEQYSvzKou9Nqj6+rLZ8f5EtM3FK0Jp5/
         w2mQ==
X-Gm-Message-State: AOJu0YyO42tLvzPzrBMzU12qWEe3J5+8YVCkAwQCrl8BT8Bca6/fQ8cN
	AAxYpOADHbcxNi8Yxi3ztAPZx9H3Nf/OSvKw4IeHA9nCilghyxR6wXMw/K2GABHjo15qmhSVaTn
	RNhAmz6DpohURfUBX7mMOYYWdIPLeFMaHRbrhZkZxXewUM0lsQbxw4OLllE5MWN0FTXXn1trP2f
	oDjjY7bXyJaaGj4XvfcObJjrq0x0zOc7kO3d3OJeV9qiA5Vg==
X-Received: by 2002:a05:6602:35a:b0:7f6:1645:d4e with SMTP id ca18e2360f4ac-7f62ee08d34mr169031739f.8.1719682219133;
        Sat, 29 Jun 2024 10:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB9ol+/yi+/lVH6E3oqZ9GTd1qtkBkgUiTl5kjaZQTcJpJDBKarZM0YKg3vSctjG1v7WQ0cA==
X-Received: by 2002:a05:6602:35a:b0:7f6:1645:d4e with SMTP id ca18e2360f4ac-7f62ee08d34mr169028739f.8.1719682218697;
        Sat, 29 Jun 2024 10:30:18 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73f90f64sm1166064173.96.2024.06.29.10.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 10:30:18 -0700 (PDT)
Message-ID: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
Date: Sat, 29 Jun 2024 12:30:16 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/2] fat: convert to the new mount API
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This short series converts the fat/vfat/msdos filesystem to use the
new mount API.

I've tested it with a hacky shell script found at 

https://gist.github.com/sandeen/3492a39c3f2bf16d1ccdd2cd1c681ccd

which tries every possible option, including some with invalid values,
on both vfat and msdos mounts. It then tests random combinations of
2, 3, and 4 options, including possibly invalid options.

I captured stdout from two runs with and without these modifications,
and the results are identical.

As patch 2 notes, I left codepage loading to fill_super(), rather than
validating codepage options as they are parsed. This is because i.e.

mount -o "iocharset=nope,iocharset=iso8859-1"

passes today, due to the last iocharset option being the only one that is
loaded. It might be nice to validate such options as they are parsed, but
doing so would make the above command line fail, so I'm not sure if it's
a good idea. I do have a patch to validate as we parse, if that's desired.

Lastly, this does not yet use the proposed uid/gid parsing helpers, since
that is not yet merged.

Thanks,
-Eric



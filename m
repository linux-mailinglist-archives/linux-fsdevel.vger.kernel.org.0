Return-Path: <linux-fsdevel+bounces-60196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B6EB42976
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 21:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408DC1BC4BC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7360A2D6E6D;
	Wed,  3 Sep 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="XOerv8Bw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157220EB
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926428; cv=none; b=ZxTWXsmaVvivAEUNcOwAiD+4jZ3c7Rp7ZXE/PQE8fPF2ws1I7GnZL4oB0fiZM4Obkzs9SVRE43reG1O98bUsu2iOy/11aklF2ZGCJmf3gQOUk77dzo3n43MKFA0IyVgcH5XrWm8XIUNwFi0/xueEoLu4/US4xrw4irErbiCUccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926428; c=relaxed/simple;
	bh=U1oIavostDSKnpqc0vnBmvjnkxNXE1USi2/5RLWKKOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o91RLviSrJG96cQp7sPsj2+E3IL0Nur836qso8F8vAWIewY0ThTioa4mW/jZ6mf0D67qXSp5fMnrY2TssKmOvNU8t7OCjTAsRxD3Pv+IIwB7w/EMJbgd//btypX8uCkp9UKZVN4ENmz9NLOdiZOTX9dlbUgprJ/nnV9tWbZLbFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=XOerv8Bw; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e9d5e41c670so333688276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1756926425; x=1757531225; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U1oIavostDSKnpqc0vnBmvjnkxNXE1USi2/5RLWKKOo=;
        b=XOerv8Bwfk7E77fLQsXcjGKgZELfoAFnty6zdLabnx6RVLmeGFdM+CVDDNie6B5rb5
         Hlv0GJBGQ1d16rvtYEuE22xsIjJNu0nRgcJs5ye1WYe0kqKEae77RvYt334+4YjdPBP+
         OybR3sSovOPVRsELbh31y5+QgUjwgTaf7BUlzb8m1g4nduQvlyTIZ79n/Qo4Z+bNrSB4
         Ja2d6hxiM/vsPETxMQJk7nd2Vq6g/ZMRpmejXhlF77LrjEO3a1i7YiRhhYnLlb2h4q+A
         h/gcQbAQNs65TUjR2PIYOj5jYWDwbGURvGgVcv1kFZHrFrkqTnmJIdjo+aQrr62OZzCo
         iWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926425; x=1757531225;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1oIavostDSKnpqc0vnBmvjnkxNXE1USi2/5RLWKKOo=;
        b=QwDrHL3B5wV2l17ggeYczOgetJJc7q64gqy39cfhAc5nzv0GpqiROwwxzQSndR/IGg
         TGHwrpX8dkQHUKYslAbhRzGix2IKFLkS+HFwvjRhTIwHZY4PmiLsTuB2Gvd6D+BGrian
         Ctw5iAXeRYoGEf9YAn2qZL3/R2q0rRQjvuMytlAOhi1G1EBW4JopSzm8eNcn/yMMCteP
         W+557e76w8yLPIhpgKjrMLlcW/giptl47/3E8z9k0QPQCGIg5H1eug89P5EJ2CMgpRlt
         d1J/S8/8Xw74kReB5BLjrAKAax3Mj/1xvs2CnkE1Y7TmdwJMVY3iwJxA6wDAP8IKD6Y0
         4hqw==
X-Forwarded-Encrypted: i=1; AJvYcCWIflgCiZ0S1SFh8jHVccOeFBP9B1aH1BeILlQsz7uI60f4iy8WIUeNuUlO8J2oJIth5Nq8g45vFGHk6Kzs@vger.kernel.org
X-Gm-Message-State: AOJu0YwchXY4bYvzWJVEabBPk3T3HnkYOq4uyZUfKecnpQAsI37n3YsL
	1pXP+Eam3vRRoewvqEH009vcwIsm7wR9XpHAepIlAq+3Q5GAyg2Is5Kwp8K7eJ7oIhs=
X-Gm-Gg: ASbGncvxgCt5FMMRFpIDyN7e6ZLSrWrs9HXMA2eVGixA0v3h2ZJZXRn+WPHY7kirW+P
	oav7qWvvVvAD/Pp9ELjt78X7SzOFxsi5sten5J6ndv0U6eHgelx5C84yvbTp74Vf9bAkxGB/fJn
	63uKZ9mS3UWG7nWN4jUtH7qsyry1A3KJJQCGedfZXhgPzwEG/Nte5/VOXCNPIYhXJrRT250gYmo
	gXy3XuNlALFqK7OEjNKShw9fELY38CMeZjFy1QCnBmffGhw8GuYC+ex6SLZWTKH4XZyckzsRBPw
	kI0vF4RA1DNw5P4J0bdMAGy1gVuq6WdjffA37AMv61HBm2SWWX6O5G+ylL2F3lOb446NGsAOsD1
	X6XMTLi0j9AE74NqWJM+GhHMMuD9BbrUM
X-Google-Smtp-Source: AGHT+IH69aCPxGnshE3yn2KyKRRmdG5LOAwCv4i61IcHpKkFjTcGUg9EBy6XgysgVzbXp/4xYLqtXQ==
X-Received: by 2002:a05:6902:2688:b0:e97:fef:d515 with SMTP id 3f1490d57ef6-e98a57934c1mr19616352276.20.1756926425342;
        Wed, 03 Sep 2025 12:07:05 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:7d3:db1d:2d89:8cf9])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe1aa0b5sm1689313276.35.2025.09.03.12.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:07:04 -0700 (PDT)
Message-ID: <7a6997cf5ea0122057fc3e109a8e41f6aaf580b9.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: clear offset and space out of valid records in
 b-tree node
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com
Date: Wed, 03 Sep 2025 12:07:03 -0700
In-Reply-To: <a21fe632-cac3-4c7d-9057-b71f8efbaf84@vivo.com>
References: <20250815194918.38165-1-slava@dubeyko.com>
	 <a21fe632-cac3-4c7d-9057-b71f8efbaf84@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-03 at 16:04 +0800, Yangtao Li wrote:
> Hi Slava,
>=20
> =E5=9C=A8 2025/8/16 03:49, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > Currently, hfs_brec_remove() executes moving records
> > towards the location of deleted record and it updates
> > offsets of moved records. However, the hfs_brec_remove()
> > logic ignores the "mess" of b-tree node's free space and
> > it doesn't touch the offsets out of records number.
> > Potentially, it could confuse fsck or driver logic or
> > to be a reason of potential corruption cases.
>=20
> Patch looks good, and I don't object to it.
> But I don't know what dose it mean
>=20
> 'it could confuse fsck or driver logic or to be a reason of potential
> corruption cases.'
>=20
>=20
> What cases?
> >=20

The idea is simple. Let's imagine that we still keep the offsets of
deleted records and the "mess" inside of the node after records
movement. Currently, only number of records in node's header protects
from accessing the offsets of deleted records. But if records number
field in node's header will be corrupted somehow, then offsets of
deleted records will be considered like the valid offsets. As a result,
logic of driver or FSCK will try to access the "records" in the node's
body. And this logic will operate with the "mess" or "garbage" that we
have after records movements. Finally, it could result in pretty not
trivial issues.

Thanks,
Slava.


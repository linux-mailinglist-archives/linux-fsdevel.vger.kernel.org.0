Return-Path: <linux-fsdevel+bounces-72033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4843CDBA55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 09:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A42763017842
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E5932D7FA;
	Wed, 24 Dec 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMPfUG8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552A32ABFB
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766564034; cv=none; b=rkoeu1h2jYlxepKSaJo/Z5wXyyFjsVO+W16WrwbxNRT8Woq6Ff5so1gaJfTEFWhkPA0TqZgiPq2YQqJ55SAWIOaksOo2MGR+HdL70X+uEV1HkeSB1aMrzuojgT7lm+taSxC1dEm+k1V50T/Foa3JbNQ6G1sLilQFkhKyLKac8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766564034; c=relaxed/simple;
	bh=ANlP2RTiBEYZ3OXY08KdvkroIgKEkYDjdCmjpktv9/k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R9HGrv/TCnRZ5khcLEHNWl5ltRSoDaKdoHK3nHRUbF2p4sbK7PAuRj8hoDztUlE5Quw/pvJdOdWryjB+ZGwsyESOPeFBttKwCax6m88RQJTHLho2KRB1VrUXZfk9S0IyFE6lEiFyt8zF0fCsSNBwLkjgmJv56xCP1zi1gHt+gaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMPfUG8s; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so6711700a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 00:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766564029; x=1767168829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tTD4JIx5gOFZt4JYkYU70Ji53+t6REw8iLK7WTmxVaM=;
        b=AMPfUG8sdSFc3hgcpjF9Dzy5McW+myufqKYwnXm7i+p2CO+LwVK08Fs/m4z+IXG884
         GXsCBLeeZUpoj8ZqSd5x9KLIcF82BTtyVWXQPEqK8eNPrnHr08WIhnj4qjDIMgtMKlEM
         hDMEoWL8IlUwpYoc42r82mZ6Sqim6N9RVh3pMbfaf0eh+73oquYGmB5BD3H964/bLnwO
         dKK5F/mruFdwjdkDdJ+BxTgiWS3H2+t5yms/sJT6L0yyMxn9hCLTkcL6NAxtq0H5ulwL
         ljfXMQlJg5YQuk4Q03kQGdB8U639AOUnTTkf1S2xAdq349CLElFvWefcZKRy/jaWDeT/
         SJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766564029; x=1767168829;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTD4JIx5gOFZt4JYkYU70Ji53+t6REw8iLK7WTmxVaM=;
        b=WqdYFreVZHIIBry/x/mW1hgd21ZC6wUKRkZix74wDuDWiTQxOoXXqXirzCAjWQvYDx
         YNtm//KgHC0d9InSGy3nwnSgkA4PmBR4LfibtJ7Ol7YLBy4cgqicu0to46tvN3DBOXBV
         SJsMgTXX+6oL+EH//P4N5BWV8Jz6lSZScuV6cpFl7pZ0vYH9GXHDHadebpqc/+uWExKp
         o0GcclQ6mWwtLC2A0oje5KmAkdhE+oUR+8lAMIu3/Ws0UutakfVujvSZ80uMo+UmWE2u
         BixufEbPhL4l/Ss/VObGTsbKyoG8fbd8yookSlS6RA3ySr+8XgI7Np/+2l9AW6gFpzvV
         DcLw==
X-Gm-Message-State: AOJu0Yzitld0COu1UYp+pP0aQPFcYRRRpCsIOWmzZIB95vsw+C4k+Iop
	RjTxhQqGWNtyvXNzknsSwW4wtU9DHaONZtFkf8QjPnBPo6b4Kem9SwqT6dmHn+k9aRE4hyoN510
	5376bjxtsYfhEnQGQ6UU8q9TMG8mvOTnkiPjsP7f2lQ==
X-Gm-Gg: AY/fxX73/yujVjOce/KdZWtj48uAGqKrUR0BHPIkibP1nILFPFdNDrZcNWCZFmhOP7V
	jztN7bcDmOSVD/sJoEeTpZHAHogviY8SgOl68lHgPrLkETJgwNUH0vxA4/RTHJDsqlwOQjJv2FD
	//7QNgSFiJgR2nx0nlXikvFO8TjMDF5+IPFeDR6uCV5gIrm4LfycTaDD5vogz6mvz2Q1t6kAyGm
	Um9/22s+l6XyIrhwE9KC7HSsnh06VAxW+MNmzGsLWVP7hqbYdlolyZvSZtvsF4HITlKHw==
X-Google-Smtp-Source: AGHT+IG9U8hLm1+ZlzHwnaIYALveLzQfY0L1KRvIu6JTP3O5TzDlN2Nne3CHVUF1kIawoDaYUmbZ6WEJWQiwzZblS2o=
X-Received: by 2002:a17:907:6ea7:b0:b73:8639:cd93 with SMTP id
 a640c23a62f3a-b8036f2ab38mr1672117666b.14.1766564029232; Wed, 24 Dec 2025
 00:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gang He <dchg2000@gmail.com>
Date: Wed, 24 Dec 2025 16:13:36 +0800
X-Gm-Features: AQt7F2oDOnvQ0VOIKrgcrL2w3HSsSQYmOKiDizWNQ1R6NRmCME95xJiDweQtqZ4
Message-ID: <CAGmFzSc=YbHdaFbGQOrs_E4-MBXrM7QwXZ0DuKAGW1Ers2q=Rg@mail.gmail.com>
Subject: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: 20251223003522.3055912-1-joannelkoong@gmail.com, 
	Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Joanne Koong,

I tested your v3 patch set about fuse/io-uring: add kernel-managed
buffer rings and zero-copy. There are some feedbacks for your
reference.
1) the fuse file system looks workable after your 25 patches are
applied in the latest Linux kernel source.
2)I did not see any performance improvement with your patch set. I
also used my fio commands to do some testing, e.g.,
 fio -direct=0 --filename=singfile --rw=write -iodepth=1
--ioengine=libaio --bs=1M --size=16G --runtime=60 --numjobs=1
-name=test_fuse1
 fio -direct=0 --filename=singfile --rw=read  -iodepth=1
--ioengine=libaio --bs=1M --size=16G --runtime=60 --numjobs=1
-name=test_fuse2

Anyway, I am very glad to see your commits, but can you tell us how to
show your patch set really change the fuse rw performance?

Thanks
Gang


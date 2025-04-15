Return-Path: <linux-fsdevel+bounces-46483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2830A89F22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6785B1902954
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C87E297A40;
	Tue, 15 Apr 2025 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="o0JCyL2B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8F76026
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722819; cv=none; b=WQeqTsvgpiGvvNi9sKtMyyn4HcNIetRV5e39yISphtCD7q47UGJG5ZMejL0zB6mLuBBroJxNpph6YE1prPeATFfDVCXNBlTYSu18S5H9wITjJ1zoFStWOjkk1tajU659bi45I9AJzQhneumAYAB/ZsaypwoZ8D/emsMeuFEuZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722819; c=relaxed/simple;
	bh=lFDK6F5sYI8CZ7ZVZNcgrgcPm1N6RXTwfm2J6iznRzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pp/jP8+ZKWevf2RWcNbFr5KBmhwILWXDKDKfdJvJQl3OS7NEuCR8yhjNqvdCndfhNyKb5Y9WUnNEEDPTZRish3j+yaDVZ0SqZ4ISthpSi/xl8S+xz2YIKHPJclrruvopddKNbN67PW5RJ7RcPD/s+oIAsdZpkx5Rx6RD36FOjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=o0JCyL2B; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47691d82bfbso17498421cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744722817; x=1745327617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86uXskcc1qsSCocpq/BgOFsDleRZoYkjCqPUnhg9XMo=;
        b=o0JCyL2BhsWTRVRL8u+eAji5PF53bo5ZEqnihlOvWJmWXJv3INVRqWVNIh/CFjukin
         1WdP8Ip4RemMRFYal9AErkjU2+ubQwPC5KkqRjjJ9/gUC38jttLg5P8YYn+9uA5Cpqi0
         ledzY/59P5jMAKizDErxC2Xge0LVJRjRzQLLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744722817; x=1745327617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86uXskcc1qsSCocpq/BgOFsDleRZoYkjCqPUnhg9XMo=;
        b=ITwWDB3CBqMp87L0kLyBqMKewMh2womoRcijAo8qRKo2wFQKGkurLf2N0ryWdfxLki
         4RhlsPsnQH5qtKROCaAGbv96TXkNDo7mMT2M4GDxXD5J3jA2ubX5d6NYFqHgPtOyfboX
         ZL5bUrT6VmNzlqvOoLcMN2m/QJ2y/iGRBx7PWhC8Q1nvwAGpci7RN+raARxL3zDzYN3v
         HvlIXQhLTZ4jG5gRsi6MwjgjJ3XqtTG1TZTONqxMLABU70cgXT419nrrUsr0x8Vh20Io
         ERrOK4aAUUwyngTthxD4PIdyERL+qRAYTLMFIytFIMtaovyXyNyOe5K5QMwaybLglb9q
         xcKw==
X-Forwarded-Encrypted: i=1; AJvYcCUuvAqdnJ9zasC5Z3QXjmGYT3yip/Xngu/VSCeHmDR1XfIRUTanhrREBasn0TutcCLz/zV0U3j5tZdBe38Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4xLfxAeUjjUtUPh/+3NWTYKzohX3hk3nx/pyELt47i/JSDZt
	zZ01VwNfHlPjotgyaDWolyMLuTXZLUDv+uizjUqL+5S5q/YhX5mn2wmdu9jWiOPdVEOpXrowDjY
	VZynmRUED5hjYCSoDLCilq2w4ZkZSoRlFKSrglw==
X-Gm-Gg: ASbGncuWL4BPrXnzRjBUpOTZHUOdM2hf7R4JQrnaaSvEo4u4O2S/oEePVOLGAFM7SYt
	aFZldm4KL1OBZb6bsXLp/shWyi9yS20OlBRhgFI5cAnZ65PWx+iamPGQHvd6Qwp1FSXeJTTU5Xh
	xNKtekH+hyLwdPOJ9AzSbL
X-Google-Smtp-Source: AGHT+IHN7Kv9EbZlr4c66u0eqG8qDu/7GwokWksRXnMKQ/cjevN3BZphTen22sWZQI5QEBFnTGX4yWw+o9UtX3KgxSY=
X-Received: by 2002:a05:622a:1a97:b0:474:fee1:7915 with SMTP id
 d75a77b69052e-4797755e3a6mr231142461cf.31.1744722816660; Tue, 15 Apr 2025
 06:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
 <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com> <BN6PR19MB31876925E7BC6D34E7AAD338BEB72@BN6PR19MB3187.namprd19.prod.outlook.com>
 <8b6ab13d-701e-4690-a8b6-8f671f7ea57a@ddn.com> <BN6PR19MB31873E7436880C281AACBB6DBEB22@BN6PR19MB3187.namprd19.prod.outlook.com>
In-Reply-To: <BN6PR19MB31873E7436880C281AACBB6DBEB22@BN6PR19MB3187.namprd19.prod.outlook.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Apr 2025 15:13:25 +0200
X-Gm-Features: ATxdqUEwcYNFHKWMIBvRx475FXLP2fdIbIRWocdtS7RiggXlA-1t1_GgwhxX-KM
Message-ID: <CAJfpeguiPW-1BSryqbkisH7k1sxp-REszYubPFaA2eFc-7kT8g@mail.gmail.com>
Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
To: Guang Yuan Wu <gwu@ddn.com>
Cc: Bernd Schubert <bschubert@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mszeredi@redhat.com" <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Apr 2025 at 04:28, Guang Yuan Wu <gwu@ddn.com> wrote:

> I though about this ...
> Actually, FUSE_I_SIZE_UNSTABLE can be set concurrently, by truncate and other flow, and if the bit is ONLY set from truncate case, we can trust attributes, but other flow may set it as well.

FUSE_I_SIZE_UNSTABLE is set with the inode lock held exclusive.  If
this wasn't the case, the FUSE_I_SIZE_UNSTABLE state could become
corrupted (i.e it doesn't nest).

Thanks,
Miklos


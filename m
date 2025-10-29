Return-Path: <linux-fsdevel+bounces-66312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7949C1B724
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CD8E34A42F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42734F492;
	Wed, 29 Oct 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fQrNdVj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F433A010
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749388; cv=none; b=c6KDWust1mKmEjP1tZFr3WIgiqoYTRdzoUioezWxGSGyPJz/zSKbN/bVkuBq6CCg+oVLORPWWY5INlJkeY1VJk99HQ2g46dcHVoqc+XJXDG827gSJ5kcPhtQ3E0+d6E4+VURlsf6ZptPrjo1FAVguQZAvp3HrcQF6KTnvVxknHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749388; c=relaxed/simple;
	bh=N/H9Hc3aJwCtzPmRJOck3fIp82+NkA0LZ9tUFRkG0Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9VsZ7V2jUmeG4/Wn9O4Mdy7/YcwYhgyZH0gvpyV58SI+7UARN+33xu1kFBwUXZQGicB13etn8BQiBs8pYQMTe7O9qyDBgHrYvbiLFa9qTfcwT3sq/4H/nzXz20Iuf5AyWkyqFOFU9q3ZNAF+vTQSxQMN+HFDgU1M7ag1QbbW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fQrNdVj+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso13413a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761749386; x=1762354186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsfcHn1joSx3FYcBHFCIU4wVQAcpbVHvkEyCsZn4M7g=;
        b=fQrNdVj+n9mN+TjKgSWKOurWOx8bbFjjcpGc9rbYoX0l9pVxeVS7dwbebPzO7EyMNY
         X2a6Ew+yUq3XXoV/wDq9lkypSK+BYom/rU7WeWRWYvwk9ud2ZvZAMsTQBqg7to0voVyE
         NWPDqGEFI4ycZ4bfSeWBglO8aPeHliM7090p3jHq/UYBn2TX8A3J0QsThKh1Ht7dMrwU
         sdWywmc9wuO5fUMz26trsoLjWgo5P7gJSrB6Xfqf+DBYqgz8bPGcaEGWivFwD1drHXXf
         CRZ7/nRNpUUvgNm2zoncIx+LpnHqQOmwhHcuMIuiiS88r9eKzaxFewWxm80ztiA9EXIT
         k9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749386; x=1762354186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsfcHn1joSx3FYcBHFCIU4wVQAcpbVHvkEyCsZn4M7g=;
        b=CuaR+YKi+bEoUKOU6pje/h1TjCILYaV2QP+3RbAAjqwSkW/HjyBs7ySdr3ig/IUjKQ
         5sAzolXUH5BkqQB1x77MThz/bFVN3EpMtzklVeq3eT9raroQ3r03ULkqTf7YpTTAcVfp
         rBR9kiVxDGzQ6j3+oyZHS1p/5g1W6TckhY6xGWjcLt1vjl1os/rjBOpZQiS7N61y16vg
         OlwoOj6DPJPDXS+a5F3O/Lwb/RtiQ83g+tih3bOgymmyEuLGyh63G0z0y+L3SGjlCE02
         3FjYEsx0PGGjxusyayf0IwcdPRpLxMYOAh/28x2nv0gusG6G+XCWxhGamVEdZb3a1RIi
         JpLQ==
X-Gm-Message-State: AOJu0YwIVSX9Qx+m5Cfe90tz3tymgxRpJDuDcnAMXjaI559FCV/lhCTw
	aqy4XMtxoyUF5X+g823nsloJgqYDoRLWLjQryvAtn+kIG4mmrs1+LffkgZQtGZ4WAAcDAVvBROR
	zZa9PhfOE7uli3V8grW2BNviptDUeEFEvMrzc3VBV
X-Gm-Gg: ASbGncv2ow9ldrYegTjw+DmCYSg716M1XQSGi1ypgy6OPksy3rS2n4+vAc0ftOGQS2S
	z+qfF3q3B8FHcmGY1tb90EYmn/spqWYWz1cvS5Nv3gW/sGYHPnjztvmO1rfVo01JUY6Rv/J1HH8
	XUryVuxFlVNfGboHOu+0kuyrx7uDB5aXJg1tuBE5zcoJ7gZjGrmoVrSu24SDnWGbPVPVKYAPYOS
	KpA6MGjNbd1WtD9NU0t07R2+p14qfSKurtAIPYU+L3dRBuXbcTqC5JkA1GW
X-Google-Smtp-Source: AGHT+IHiN2wVay8qKwNUCQNQedszNEqWD+gbH8QhJy+T+EtTl6Gz4GwA6YgaiehmmoZJBoAentF29nQI5J4sc3vsbuw=
X-Received: by 2002:a17:90a:d64d:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-3403a302f52mr3761415a91.36.1761749386246; Wed, 29 Oct 2025
 07:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-36-viro@zeniv.linux.org.uk> <CAHC9VhRQNmPZ3Sz496WPgQp-OkijiF7GgmHuR+=Kn3qBE6nj6Q@mail.gmail.com>
 <20251029032404.GQ2441659@ZenIV>
In-Reply-To: <20251029032404.GQ2441659@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Oct 2025 10:49:34 -0400
X-Gm-Features: AWmQ_bkw5gzRbiAC20oxF8nOixccAI_lXABYmuYCSfnezye7FZYc2Gs15NqnG0I
Message-ID: <CAHC9VhRefx4MBDU78Qob7Pe2pDLK=1HK4b2EuTtENVssntHecQ@mail.gmail.com>
Subject: Re: [PATCH v2 35/50] convert selinuxfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> On Tue, Oct 28, 2025 at 08:02:39PM -0400, Paul Moore wrote:
>
> > I suppose the kill_litter_super()->kill_anon_super() should probably
> > be pulled out into another patch as it's not really related to the
> > d_make_persistent() change,
>
> It very much is related - anything persistent left at ->kill_sb() time
> will be taken out by generic_shutdown_super().  If all pinned objects
> in there are marked persistent, kill_litter_super() becomes equivalent
> to kill_anon_super() for that fs.

Gotcha, thanks.

--=20
paul-moore.com


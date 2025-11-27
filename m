Return-Path: <linux-fsdevel+bounces-70088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2115C9055B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 00:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B0C04E0F46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BED31771B;
	Thu, 27 Nov 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8usZ8I9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1F2E2286
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764285563; cv=none; b=ruzzWCSQ3cFsVt5KG+tYy8SwQP5yYLl0qQqnl6pDljQu0Sclh4Q+YNVzawcoD4aMj3cuPZUwPm3iVwH0ZVky7vAxiVXR8NC5VjDab0S3kw5EsTAsgydj7CinG1qDb5Xesf9gayTj2Ry0x0IlEqd0MCExtRMXtNc5wKZpqf7DmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764285563; c=relaxed/simple;
	bh=2enAuMm6I7L7TJxKqakslwb8Rmxo/sfhmljwNTTXZQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6yHjhvrulHWJAn/o94TGd3bh1/EwTRJ6pRfmfu/PSD3CJB5U0W/VBTTlCgfHlyW+oLmWJ/huqy4BlUzZMjEo9s/OmOtAZmWD/LiJk8zxikSdhxq3Ru2JLRQzjkEM4JTfZcl76owHMXafNHae4hiEi8eIm2YQ830BtQNDvGc/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8usZ8I9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F074FC116D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 23:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764285563;
	bh=2enAuMm6I7L7TJxKqakslwb8Rmxo/sfhmljwNTTXZQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L8usZ8I9sgRq9NOpmxUo/OJD/QXqPhDQx4KEtAmMWVq89nKJcQfGF8m/z36oCozSU
	 OeTCOMTQx+I0xXf1KCdFhiqFo/UCRiX/AJHdbjBDo5E1Z72ZAn3uGFR776QTuwLpSK
	 zkeW+43AwhkucX/NAwF7w8mIJuTSaSupCarfFoX0tz0HWlLq7lereIcY3DsX7hN3/D
	 numtgNk77pePD8RCaii9H5nMMUgq4oCPHhyrXfiggyiAosd8A/Q7qnnydEsEiBXuF8
	 sr7JQlYJrh83+iLDiLpXHcY59vn+rH/tVPaLxEpQaayiU7dpCU0RZ0Y+N6pci2DyMV
	 Boydkp0tipYtA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso2551942a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 15:19:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDW2FOmM/8WCLOkLuhgdm4sAffiH1+dOAieySRlUpXwVFkeeYqF/b/h+pYazc8Fs3GU6J5WqdN8HECe4Wb@vger.kernel.org
X-Gm-Message-State: AOJu0YziCFwAWkFBma9nF+0hivSCLQFN/TFG+I5qO4vzjDmSemQK5N3H
	so3B1ETj26AczxJAK9UKiKAsO9KJZm2T0Ql+U3omaDIb7df5aSQLO0Hbhoner1fdwmDlYfh2WoI
	TJb12D67NmHXo52tlM3Am2MB/cLg9vF8=
X-Google-Smtp-Source: AGHT+IFIY1v0PfFQdzXB0Uvscm4hO3G0BmJgDReLkKeFDLP9ml57/+0YuHr/daJoDoLBbu4LHJzN1lczA3Mlis8MW2Q=
X-Received: by 2002:aa7:d4ce:0:b0:640:931e:ccac with SMTP id
 4fb4d7f45d1cf-64539658323mr20243768a12.7.1764285561563; Thu, 27 Nov 2025
 15:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <CAOQ4uxhfxeUJnatFJxuXgSdqkMykOw+q7KZTpWXb8K2tNZCPGg@mail.gmail.com>
 <CAKYAXd98388-=qOwa++aNuggKrJbOf24BMQZrvm6Gnjp_7qOTQ@mail.gmail.com> <aShnFRVYMJBnh4OM@casper.infradead.org>
In-Reply-To: <aShnFRVYMJBnh4OM@casper.infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 28 Nov 2025 08:19:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8q=TLxOZi5qB8Xinq+-ErtPwwF13HOsw2JA4P-sx6kNw@mail.gmail.com>
X-Gm-Features: AWmQ_bkjOpad125o09B0SU2QRXEjGVyjhCIBAFXI5Hf9C1HLal8aqDqjBNhmZ5A
Message-ID: <CAKYAXd8q=TLxOZi5qB8Xinq+-ErtPwwF13HOsw2JA4P-sx6kNw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] ntfsplus: ntfs filesystem remake
To: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, hch@lst.de, tytso@mit.edu, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 11:58=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Nov 27, 2025 at 09:17:54PM +0900, Namjae Jeon wrote:
> > > Why is the rebranding to ntfsplus useful then?
> > >
> > > I can understand that you want a new name for a new ntfsprogs-plus pr=
oject
> > > which is a fork of ntfs-3g, but I don't think that the new name for t=
he kernel
> > > driver is useful or welcome.
> > Right, I wanted to rebrand ntfsprogs-plus and ntfsplus into a paired
> > set of names. Also, ntfs3 was already used as an alias for ntfs, so I
> > couldn't touch ntfs3 driver without consensus from the fs maintainers.
>
> I think you're adding more confusion than you're removing with the name
> change.  Please, just call it ntfs.  We have hfs and hfsplus already,
> and those refer to different filesystems.  We should just call this ntfs.
Okay, I will change it back to the name "ntfs" in the next version.
Thanks!


Return-Path: <linux-fsdevel+bounces-70439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B85CC9A91D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 08:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B9C3A5DE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 07:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713B23043A1;
	Tue,  2 Dec 2025 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9U+2+6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF45303A0B
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661994; cv=none; b=LovQLoWOS5oHx3Ed27qgJj3PKwzJdRmgoKmM2PHqISSdxkYt+lebBklpgowrQWqhErfc5CHfA/9kGy5xWcaKOdBoLrofjZY8fMqPfsoRCDsnBeob/b4gD26kGCzdiSpjZT2EsppSLMNqlC9Mbb+f987OVNsNCKoabNL/jDbIr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661994; c=relaxed/simple;
	bh=jtoOIsAb4N/aQPXYiDOsT0mLcSZuaW9KJU71fSWdaWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuqnaaKbOWQ1pjlx+wSheLsb5yUSHHbq6OJoRsvGphfUxWs1ArDBkfnL4Dhqg9EcrWzyb1BJB2bJiGJFEU7tEdAgHR+I3cDyqyVHUar+iVKl2MR/IbTz+AmTIgQq/Y7A83hpCvYd4HbnDmjOSmHWiFWNT365g9RDbUXc57pwgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9U+2+6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5A3C116D0
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 07:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764661994;
	bh=jtoOIsAb4N/aQPXYiDOsT0mLcSZuaW9KJU71fSWdaWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A9U+2+6iQaXmDD9B3/CFCJ5WxKxfsbS+dXNck6qkeSI/tuRWQCpS6bBzb49WrWYIp
	 vMjqZFbmQCgH6MbdAMD0ncSask1yhSOiT9yawg7Eho7Lhn/Wm0Xa3PPb32Pi7ojBfx
	 +A3kepJAom2iPulz7V1irZt2HCSW7foYrlUNOr/CXcAVl8hBUl0JVLDGJVvto5DxcY
	 pa1K3ew0uGPqjNW1W01hWgX41RiDvF1/uWDQrlY1Yz79I6xnMU30FxUocIY5KVhish
	 gvpJ8byn0HvvE9o9toCfxowdhSHrKUGVm+cQBgoQIbTB60kcWEZOpI+nEP5zdDjWV2
	 ch5llnCA1BRyg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7373fba6d1so807104366b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 23:53:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUR4fNsgmkDr3tph5k218yUfj6VVztge+ext2xxN0nRyBk3EqKm9MDGiZKupGssNvl8O7DJJGww60LCvsML@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XX29gFAVkxvXFQnp8paZPmQBpQqZZhqsOx7kukqQvu/z0znV
	JPLwDeMQ5JlrmvSSHI/5xhdTbV9+IWvBYGFxvW/bO+ENOCnyBb5It3XyXn+V0y5Dl55UfsvVhdn
	PVWpLcAtGoZD4Ro++RSj3gOUjqumh20Q=
X-Google-Smtp-Source: AGHT+IGaPtA3Z6AB2Jgji5GVEjzrKRXy2RpvjIBJ0Wi3BAfm592z/mltlVN6ytVUdj1A/qS1JnixBMidJPW0qyIAFtQ=
X-Received: by 2002:a17:906:9fc9:b0:b76:4426:3a3a with SMTP id
 a640c23a62f3a-b7671b1b585mr4967887266b.58.1764661993030; Mon, 01 Dec 2025
 23:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-7-linkinjeon@kernel.org>
 <aS1FVIfE0Ntgbr5I@infradead.org> <CAKYAXd9YW_UL2uA8anoVCw+a818y5dwtn3xAJJQc=_p32GA=Zw@mail.gmail.com>
 <20251202054524.GB15524@lst.de>
In-Reply-To: <20251202054524.GB15524@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 2 Dec 2025 16:52:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Gzk+7Gwh1GTVbeNUygNWVnmNu458F67Y5fhcpapEFBg@mail.gmail.com>
X-Gm-Features: AWmQ_bmGJ-KfRwoEGGS2y_M3WqNq9-yp4h_I_7fTwIsF-mKDYOHzxQxEEx4MKmU
Message-ID: <CAKYAXd-Gzk+7Gwh1GTVbeNUygNWVnmNu458F67Y5fhcpapEFBg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] ntfsplus: add iomap and address space operations
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 2:45=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Tue, Dec 02, 2025 at 09:47:17AM +0900, Namjae Jeon wrote:
> > Nothing special reason, It was to use existing ones instead of new,
> > complex implementations. NTFS metadata is treated as a file, and
> > handling it via the folio(page) API allows the driver to easily gain
> > performance benefits, such as readahead.
>
> On the one hand it does, on the other hand at least our experience
> is that the user data file algorithm for things like readahead and
> cache eviction policies worked pretty poorly for metadata in XFS.
> Of course I don't actually know if the same applies to ntfs.
We have observed performance improvements from readahead for NTFS
metadata since we are able to identify the continuous cluster ranges
of metadata files.
>
> > > From code in other patches is looks like ntfs never switches between
> > > compressed and non-compressed for live inodes?  In that case the
> > > separate aops should be fine, as switching between them at runtime
> > > would involve races.  Is the compression policy per-directory?
> > Non-compressed files can actually be switched to compressed files and
> > vice versa via setxattr at runtime. I will check the race handling
> > around aop switching again. And the compression policy is per-file,
> > not per-directory.
>
> In that case you probably want to use the same set of address space
> (and other operations) and do runtime switching inside the method.
Right, I will change it.
>
> > >
> > > Again curious why we need special zeroing code in the file system.
> > To prevent reading garbage data after a new cluster allocation, we
> > must zero out the cluster. The cluster size can be up to 2MB, I will
> > check if that's possible through iomap.
>
> Ouch, that's a lot of zeroing.  But yeah, now that you mention it
> XFS actually has the same issue with large RT extents.  Although we
> create them as unwritten extents, i.e. disk allocations that always
> return zeroes.  I guess ntfs doesn't have that.  For DAX access
> there actually is zeroing in the allocator, which is probably
> similar to what is done here, just always using the iomap-based
> code (check for xfs_zero_range and callers).
Right, ntfs does not have a direct equivalent to the unwritten extent mecha=
nism.
I will check xfs codes. Thank you very much for the detailed review!


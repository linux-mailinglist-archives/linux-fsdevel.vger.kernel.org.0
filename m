Return-Path: <linux-fsdevel+bounces-42163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30ECA3D905
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 12:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B078C17F0F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155051F461B;
	Thu, 20 Feb 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cG61DCDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21D1F4169
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051556; cv=none; b=Qms3RPk2aJyTXmtj4CQwubqbAucy1I9XmSRrKDvQLilAbanLiOoNSX2h7l0N0nc7YjTWev94XAlAn1U7vxsXCFDav10z/sIPm5j/HFvJ2lcePM5J/PDaIS3hEaCVFPqCDgtCnn/ADTdYPAhTnJDX+4LxZEsu2qKUg7n8fUEH9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051556; c=relaxed/simple;
	bh=UglG67D28+osv68sC3XCjElFJ5LUWGApP0ptxB1m3pU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFNUlEianwXUVLv0R/O21DiLc069fsR6x/u3bVnT9v3fmmplfh0CQYD5trNcLc9w3nx0GDyhMHnccRTe+b20TUfZDM+gD7CgFDQwJq909M48WgqNNAz3LpD1JVAjIlKKvnVsncy2p94x/3Jc/ZQLLSkIOz+pzW9qHz/OUWvGPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cG61DCDy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740051553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Znby4ZKGO+Rjp4MAMe63MEhaeWs0isJ3Wye8nSkpXks=;
	b=cG61DCDymqU2gkIcVWVvCEYLQUP2zAayE0PUohkEnCo8myVTo/RKqGsyqFdtmZDdf+b+fK
	R8Qmjj44YYw//1XYXoMGzuNsqIapIgisEqMKWekszWwXtEUooYRxzmrj7GGIiFqVIuYTGO
	Csmm/nrNSqZ8b40jMUsDzT/iTLQjqCY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-XVzM_VhFN0urk93UQgPg0w-1; Thu,
 20 Feb 2025 06:39:10 -0500
X-MC-Unique: XVzM_VhFN0urk93UQgPg0w-1
X-Mimecast-MFC-AGG-ID: XVzM_VhFN0urk93UQgPg0w_1740051549
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DBD81801A18;
	Thu, 20 Feb 2025 11:39:09 +0000 (UTC)
Received: from localhost (unknown [10.44.33.68])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93ED31800943;
	Thu, 20 Feb 2025 11:39:08 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  Miklos Szeredi
 <mszeredi@redhat.com>,  linux-unionfs@vger.kernel.org,
  linux-fsdevel@vger.kernel.org, Alexander Larsson <alexl@redhat.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
In-Reply-To: <CAJfpeguv2+bRiatynX2wzJTjWpUYY5AS897-Tc4EBZZXq976qQ@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 20 Feb 2025 12:25:59 +0100")
References: <20250210194512.417339-1-mszeredi@redhat.com>
	<20250210194512.417339-3-mszeredi@redhat.com>
	<CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
	<CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
	<CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
	<CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
	<CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
	<CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com>
	<87a5ahdjrd.fsf@redhat.com>
	<CAJfpeguv2+bRiatynX2wzJTjWpUYY5AS897-Tc4EBZZXq976qQ@mail.gmail.com>
Date: Thu, 20 Feb 2025 12:39:07 +0100
Message-ID: <875xl4etgk.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Thu, 20 Feb 2025 at 10:54, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>
>> Miklos Szeredi <miklos@szeredi.hu> writes:
>>
>> > On Tue, 11 Feb 2025 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:
>
>> >> The short version - for lazy data lookup we store the lowerdata
>> >> redirect absolute path in the ovl entry stack, but we do not store
>> >> the verity digest, we just store OVL_HAS_DIGEST inode flag if there
>> >> is a digest in metacopy xattr.
>> >>
>> >> If we store the digest from lookup time in ovl entry stack, your changes
>> >> may be easier.
>> >
>> > Sorry, I can't wrap my head around this issue.  Cc-ing Giuseppe.
>
> Giuseppe, can you describe what should happen when verity is enabled
> and a file on a composefs setup is copied up?

we don't care much about this case since the composefs metadata is in
the EROFS file system.  Once copied up it is fine to discard this
information.  Adding Alex to the discussion as he might have a different
opinion/use case in mind.

>> >> Right. So I guess we only need to disallow uppermetacopy from
>> >> index when metacoy=off.
>>
>> is that be safe from a user namespace?
>
> You mean disallowing uppermetacopy?  It's obviously safer than allowing it, no?

sorry I read th "only need" as "loosening the conditions when
uppermetacopy is allowed"; so I was asking if there are cases when
uppermetacopy is considered safe in a user namespace (if there are any).
If that is not the case, please ignore my question.



Return-Path: <linux-fsdevel+bounces-45067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C60A71478
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490BF3ADFFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C491B3939;
	Wed, 26 Mar 2025 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qwjjSp8A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E551A83F5
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983871; cv=none; b=BmjMaLsSxQ5ld+4vNlNF9Bm0dQqKZ/V/AJBuP2xgKD8396l+cCqS9edQGO5XtvKi3ntBvfvSWuS7TVqCV9YSngdoVdo45xHXdkHZBe+KNOOxls14MQU33jCyKXUUtr1EGrkSGzNUdvHE4/47izz+yVVDgF/cyBEH0jfTGJ5J4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983871; c=relaxed/simple;
	bh=HnyPChT1rHVmaHzJGsHbOlfv8XMG3sq37y9Rgbth8ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zyir6X/62W6JCkN469Kplc9EAGSkRrHUNnTQ3WskPGkl6ia1f9c/xhEO41dliZ+0O2qGnV+wXAgrdx7iSa93EnmC/0t1Z62pjtLKvo3gUrsLin76Wpwsg7fvtQ5NMZAeY7o2atCzwwLTpgdVaecSD2iHOn5JBNfT6aHoMvdLj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qwjjSp8A; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/dCNR6GVF9aLu5e35W/aTIZ1RvDqLKERY5YgN7EnyN0=; b=qwjjSp8AS/YMZRMCed4VOx4JTd
	J8h/JW8/yOXIR2CyZxf3dAFy20/BVUgfvw0ZrUQutfNlXcLWVzs+P31xCQoGTd7ZqEGUTSLsihm7g
	2soBIAKrf1o6Qq8nou2JW1I5rQpWZdKGD7vkzIhQwfjparAsSq1zZpQOial3kj5FjEqFFf6X4+PCL
	xcqoGqN9ibxP/Je976iRe9Nbz4LlEhtMm1+PT46LLpNTl/obUXqwUIi6zqzbmC+nzMgCNWupB6LbJ
	Hdv4h8SDMYo6IJAnR7OtolWdzr6ysI1VOd0viBaMvLrr3jSLxL8/4kJPlS5rEoNIogPU1c3oXmvYy
	vRrv4azw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1txNip-006XV0-KE; Wed, 26 Mar 2025 11:10:55 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Joanne Koong
 <joannelkoong@gmail.com>,  Jeff Layton <jlayton@kernel.org>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,  Miklos
 Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH v2] fuse: {io-uring} Fix a possible req cancellation race
In-Reply-To: <01d4007d-4f25-4014-b8a0-a59cf6d17aeb@ddn.com> (Bernd Schubert's
	message of "Tue, 25 Mar 2025 21:53:39 +0000")
References: <20250325-fr_pending-race-v2-1-487945a6c197@ddn.com>
	<87pli4u6xy.fsf@igalia.com>
	<01d4007d-4f25-4014-b8a0-a59cf6d17aeb@ddn.com>
Date: Wed, 26 Mar 2025 10:10:49 +0000
Message-ID: <87y0wsgl06.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25 2025, Bernd Schubert wrote:

> On 3/25/25 22:38, Luis Henriques wrote:
>> Hi Bernd!
>>=20
>> On Tue, Mar 25 2025, Bernd Schubert wrote:
>>=20
>>> task-A (application) might be in request_wait_answer and
>>> try to remove the request when it has FR_PENDING set.
>>>
>>> task-B (a fuse-server io-uring task) might handle this
>>> request with FUSE_IO_URING_CMD_COMMIT_AND_FETCH, when
>>> fetching the next request and accessed the req from
>>> the pending list in fuse_uring_ent_assign_req().
>>> That code path was not protected by fiq->lock and so
>>> might race with task-A.
>>>
>>> For scaling reasons we better don't use fiq->lock, but
>>> add a handler to remove canceled requests from the queue.
>>>
>>> This also removes usage of fiq->lock from
>>> fuse_uring_add_req_to_ring_ent() altogether, as it was
>>> there just to protect against this race and incomplete.
>>>
>>> Also added is a comment why FR_PENDING is not cleared.
>
> Hi Luis,
>
> thanks for your review!
>
>>=20
>> At first, this patch looked OK to me.  However, after looking closer, I'm
>> not sure if this doesn't break fuse_abort_conn().  Because that function
>> assumes it is safe to walk through all the requests using fiq->lock, it
>> could race against fuse_uring_remove_pending_req(), which uses queue->lo=
ck
>> instead.  Am I missing something (quite likely!), or does fuse_abort_con=
n()
>> also needs to be modified?
>
> I don't think there is an issue with abort
>
> fuse_abort_conn()
>    spin_lock(&fiq->lock);
>    list_for_each_entry(req, &fiq->pending, list)
>    ...
>    spin_unlock(&fiq->lock);
>
>    ...
>
>    fuse_uring_abort(fc);
>
> Iterating fiq->pending will not handle any uring request, as these are
> in per queue lists. The per uring queues are then handled in
> fuse_uring_abort().
>
> I.e. I don't think this commit changes anything for abort.

Yeah, you're right.  Thanks for looking, Bernd.

>>=20
>> [ Another scenario that is not problematic, but that could become messy =
in
>>   the future is if we want to add support for the FUSE_NOTIFY_RESEND
>>   operation through uring.  Obviously, that's not an issue right now, but
>>   this patch probably will make it harder to add that support. ]
>
> Oh yeah, this needs to be fixed. Though I don't think that this patch
> changes much. We need to iterate through the per fpq and apply the
> same logic?

Right, I agree this patch doesn't change anything here.  And I guess I
also misunderstood the problem here as well -- I thought this would be an
issue when adding support for iouring, but in fact it is already a
problem.  The ideal solution would be to implement NOTIFY_RESEND over
iouring, but that would be a bit more evolving.

Cheers,
--=20
Lu=C3=ADs


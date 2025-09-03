Return-Path: <linux-fsdevel+bounces-60203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA3B42A83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CB3F4E0606
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE952DFA21;
	Wed,  3 Sep 2025 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Dt60aeY4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831E2D0618;
	Wed,  3 Sep 2025 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930103; cv=none; b=gm96dprXHtpBTb3gWSaVgPANhQQUC59jZJlsL71G0eIy/lSUMiuUkNjdga6tVM/EoFV1+vobLVlnAK9Sz+zjsajDhGDBrDWgA+S6YJ5qrpGYVYsKlJHP5+hith4rLATQaqppH4CoRT6nIK+zkz7h0WrH7tf+2NkfuTbcl+R7tMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930103; c=relaxed/simple;
	bh=CJE/pBfUWtOCYKvA8tRHpgYAj6ofkAXAxWG86Ccd0/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OKv39XxWL17BQVE65bGa9sUsPK5MRf0c9dzMNHxI+WJXIJQs6OKpAy7K+6ACKBhbjP15gGPeNXwHMpQv+deL6AubCJKepEnQ33TCqndQOBNA/fSJENFPwZi9Y5qA2bKsxyOn9RPZB1ATN33phYdjDbiwtcfoVEIzaMrK5zG8I4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Dt60aeY4; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=upyZwsJJctIX0uCSmJ5fehPuJIm/cSQbmATHzKXkAjo=; b=Dt60aeY42+kEz2SDQX0Chxprxk
	AGDtyiErvFksEjINXeJpOpktK3uFVtJ6tT++pdRMxvYSQ9WTnD25DU2NpvLRku98Q+16ot77hE4D1
	QTovnfdqAgUSV4d5MCf2DwJ7uZ3oag2I3CyIVJDG+KYXhKvV3UX0GENufcHcnOLYUU2d7h+O4r3Zh
	3yoyiQN/EpBFxMjtbwuJU6s4qNO10rcp9oKDrEhDKzRLiLwlYqAGFhWsajYlFBngXrNq3mg9vi6KG
	kMExJBqLnnCsUJplnMGnENFj8Z+gUaJlytQBIuNBdyveIMMLuDtGCh8gSN/s68lOW/Wb+Or957Sw7
	x7p2SBKw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uttmB-006OE9-Jh; Wed, 03 Sep 2025 22:08:15 +0200
From: Luis Henriques <luis@igalia.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com
Subject: Re: [PATCH v2] fuse: prevent possible NULL pointer dereference in
 fuse_iomap_writeback_{range,submit}()
In-Reply-To: <CAJnrk1aWaZLcZkQ_OZhQd8ZfHC=ix6_TZ8ZW270PWu0418gOmA@mail.gmail.com>
	(Joanne Koong's message of "Wed, 3 Sep 2025 10:03:28 -0700")
References: <20250903083453.26618-1-luis@igalia.com>
	<CAJnrk1aWaZLcZkQ_OZhQd8ZfHC=ix6_TZ8ZW270PWu0418gOmA@mail.gmail.com>
Date: Wed, 03 Sep 2025 21:08:12 +0100
Message-ID: <87ikhze1ub.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03 2025, Joanne Koong wrote:

> On Wed, Sep 3, 2025 at 1:35=E2=80=AFAM Luis Henriques <luis@igalia.com> w=
rote:
>>
>> These two functions make use of the WARN_ON_ONCE() macro to help debuggi=
ng
>> a NULL wpc->wb_ctx.  However, this doesn't prevent the possibility of NU=
LL
>> pointer dereferences in the code.  This patch adds some extra defensive
>> checks to avoid these NULL pointer accesses.
>>
>> Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>> Hi!
>>
>> This v2 results from Joanne's inputs -- I now believe that it is better =
to
>> keep the WARN_ON_ONCE() macros, but it's still good to try to minimise
>> the undesirable effects of a NULL wpc->wb_ctx.
>>
>> I've also added the 'Fixes:' tag to the commit message.
>>
>>  fs/fuse/file.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 5525a4520b0f..990c287bc3e3 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -2135,14 +2135,18 @@ static ssize_t fuse_iomap_writeback_range(struct=
 iomap_writepage_ctx *wpc,
>>                                           unsigned len, u64 end_pos)
>>  {
>>         struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
>> -       struct fuse_writepage_args *wpa =3D data->wpa;
>> -       struct fuse_args_pages *ap =3D &wpa->ia.ap;
>> +       struct fuse_writepage_args *wpa;
>> +       struct fuse_args_pages *ap;
>>         struct inode *inode =3D wpc->inode;
>>         struct fuse_inode *fi =3D get_fuse_inode(inode);
>>         struct fuse_conn *fc =3D get_fuse_conn(inode);
>>         loff_t offset =3D offset_in_folio(folio, pos);
>>
>> -       WARN_ON_ONCE(!data);
>> +       if (WARN_ON_ONCE(!data))
>> +               return -EIO;
>
> imo this WARN_ON_ONCE (and the one below) should be left as is instead
> of embedded in the "if" construct. The data pointer passed in is set
> by fuse and as such, we're able to reasonably guarantee that data is a
> valid pointer. Looking at other examples of WARN_ON in the fuse
> codebase, the places where an "if" construct is used are for cases
> where the assumptions that are made are more delicate (eg folio
> mapping state, in fuse_try_move_folio()) and less clearly obvious. I
> think this WARN_ON_ONCE here and below should be left as is.

OK, thank you for your feedback, Joanne.  So, if Miklos agrees with that,
I guess we can drop this patch.

Cheers,
--=20
Lu=C3=ADs

>
>
> Thanks,
> Joanne
>
>> +
>> +       wpa =3D data->wpa;
>> +       ap =3D &wpa->ia.ap;
>>
>>         if (!data->ff) {
>>                 data->ff =3D fuse_write_file_get(fi);
>> @@ -2182,7 +2186,8 @@ static int fuse_iomap_writeback_submit(struct ioma=
p_writepage_ctx *wpc,
>>  {
>>         struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
>>
>> -       WARN_ON_ONCE(!data);
>> +       if (WARN_ON_ONCE(!data))
>> +               return error ? error : -EIO;
>>
>>         if (data->wpa) {
>>                 WARN_ON(!data->wpa->ia.ap.num_folios);



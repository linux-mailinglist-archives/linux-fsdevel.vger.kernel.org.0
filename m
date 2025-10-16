Return-Path: <linux-fsdevel+bounces-64331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B594BE129C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 03:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC523541E44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 01:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FE1DF970;
	Thu, 16 Oct 2025 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlR1Ugri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9454A00
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578044; cv=none; b=I9X449HeQptzz/x0WxbCRdLAedTC6qDmji+JFrZK8qKcbrS25BuBdr2ZMML7LKaN9Xjk7epvY/ZzEkVeolbWOTKq2uK6TYCVXyVNnUteWpyLBDK+zWowldFICTEvqWn5kI/jHKOSlRJlBacifa46VW05LsU9M3fJmpWktMGh0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578044; c=relaxed/simple;
	bh=PvF2Klus8jVn8hw8gSM0WaRROcBDIAS5aCXX1qudGXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNcIi3kLhLEWCNrRqT6LK8nWjWDp6P+hDD98TEej6T1pEqFVSvkLc1juZur0VIvhxGTiHWIezYlrjH5l6+Ifx5mWqNmgKPna6lbaV3GPMrYsUTKLHswuu5TcxZFvZOg8RWh8jfi9oMJYmPmJLSQyV7fPCph3GeNL0tZmvLKlDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlR1Ugri; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88e4704a626so31202785a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 18:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760578041; x=1761182841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eedQM2DF1mPp1kVko6eRaQAhkrlcDjOydVgTY+hJAhU=;
        b=MlR1UgriaRdWzyxdnC1iehxfPMFoDzaOslncox3w3rmNWm2Q1BJ2FNxmA9l4sYaLTv
         gRKHGVQxnn3alJTX3rjrr5L4sIXefde6pwrcG77H8WR+G0LrQ3bDAHNlFby1Xt8j+BOh
         Auj3x78bgqFcmMemiZLK6zxSd1LcCoYgjou4CLXZe2dy52KBgdVK+P+umiLSyr5tHlga
         BwyKw90p52geA/A+SCBzLAsGR98+12JZEYR28atZQGOQ3atGfBlpUYQQdcHt0IQyA/wy
         b3h+bKFCa85eOSz0fTFnkEKY0hfK4Pnm5I2Hu0F4duchF0xp4MJ5A1UI3+/hgitTOmCa
         XeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760578041; x=1761182841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eedQM2DF1mPp1kVko6eRaQAhkrlcDjOydVgTY+hJAhU=;
        b=jktkSOzx23tHgJUaZcfeXg0Dtc8uhDnYtCaJRIOpe+qo8q5vcJ0sVT6tfuEbEuEyr6
         +7jeyBDygQ+PG20WfVKf0CDCd+6VJ6vBe+bralFDchcpfUOCZRW3Q0t/dzRRldZzTExC
         wIKtnoG3Pkwh7fz8kv225Wm6L+hMn6t4c8FKzoC1NPUFIEVdjQPBLKywILMcPuOSryaH
         GIYX7A4QbcRB/sf5RzTmLarOmiTzQrjZ87n81cii7joh/f3WbcVuTy43ce/ntlicSHR5
         xBR6W0XiUR7/LuApEuWqMUjhWHym5FRZSw0fuWKEdnVweCWlBJRvxV32ZoFmm5kQ5nkA
         wirg==
X-Forwarded-Encrypted: i=1; AJvYcCU757n/wN2UMIsX1DQIWQTu2JMslpDsT2qwaQ1LSixRYVhv0HqxtwUOPg7EHWLQIsmnr3M1ycB4YoMpYd8p@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2EzPFejMkYEUnvTo9Kqyzxu95vHQrr2D81VcjWOgv6a2DUXq
	qBY3mZoi15hLDuCKy+cSUHw6ME4cmfM4fqKYDO88zgyHYmU0WdotbH+iCva869I+QnymJN3ciuC
	yGfaFrl3qKAvJXXLt4qKmBIWt/qkbJnc=
X-Gm-Gg: ASbGncuU6dubdGh2PEa/BVdHVUMYT+SWOy+E26i6cu195orAcLic2H8Dm43tD1iqn8l
	DPZDTTovDhBAULdTGASxE6TN/1X0JrYwqjU8X5RhOVahBQinLcuPPMtC6hPw1eNM5gO3xPUtRwg
	6k9k4ucIOBBrlL5Rpul7GSeTQST77kmshjict3gpJqhLN832tOlFhgKas4P2dxqBGMRTySZa+4A
	3Epdf4Fnph5cR+rpc7yYOWvStiAvabgDVUSQf8k9H9GO68IgJ2fVTYHLWK+DYiEr6gZwONU/J1W
	P3khg0/OvdVgtRg7PjRv4FDF1fE=
X-Google-Smtp-Source: AGHT+IGaQwtvfbtLhqa5nVZR1btCKx04CtYnQsr+C7z61gY1O+D0DZMsZsAN082qSH1VBNaBxhLCPuSMDSDsiTSDIcg=
X-Received: by 2002:ac8:7f0a:0:b0:4e8:9596:ee7c with SMTP id
 d75a77b69052e-4e89596fadbmr2718101cf.1.1760578041087; Wed, 15 Oct 2025
 18:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com> <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com> <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com> <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com> <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
In-Reply-To: <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Oct 2025 18:27:10 -0700
X-Gm-Features: AS18NWCvd2_hvZ3Hwv1_pa-4WxUbTgPlpETBC2IlRutG4VIRLLbuWF59gspslb8
Message-ID: <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Oct 15, 2025 at 11:39=E2=80=AFAM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote:
> >
> > Hi Joanne,
> >
> > On 2025/10/16 02:21, Joanne Koong wrote:
> > > On Wed, Oct 15, 2025 at 11:06=E2=80=AFAM Gao Xiang <hsiangkao@linux.a=
libaba.com> wrote:
> >
> > ...
> >
> > >>>
> > >>> This is where I encountered it in erofs: [1] for the "WARNING in
> > >>> iomap_iter_advance" syz repro. (this syzbot report was generated in
> > >>> response to this patchset version [2]).
> > >>>
> > >>> When I ran that syz program locally, I remember seeing pos=3D116 an=
d length=3D3980.
> > >>
> > >> I just ran the C repro locally with the upstream codebase (but I
> > >> didn't use the related Kconfig), and it doesn't show anything.
> > >
> > > Which upstream commit are you running it on? It needs to be run on to=
p
> > > of this patchset [1] but without this fix [2]. These changes are in
> > > Christian's vfs-6.19.iomap branch in his vfs tree but I don't think
> > > that branch has been published publicly yet so maybe just patching it
> > > in locally will work best.
> > >
> > > When I reproed it last month, I used the syz executor (not the C
> > > repro, though that should probably work too?) directly with the
> > > kconfig they had.
> >
> > I believe it's a regression somewhere since it's a valid
> > IOMAP_INLINE extent (since it's inlined, the length is not
> > block-aligned of course), you could add a print just before
> > erofs_iomap_begin() returns.
>
> Ok, so if erofs is strictly block-aligned except for tail inline data
> (eg the IOMAP_INLINE extent), then I agree, there is a regression
> somewhere as we shouldn't be running into the situation where erofs is
> calling iomap_adjust_read_range() with a non-block-aligned position
> and length. I'll track the offending commit down tomorrow.
>

Ok, I think it's commit bc264fea0f6f ("iomap: support incremental
iomap_iter advances") that changed this behavior for erofs such that
the read iteration continues even after encountering an IOMAP_INLINE
extent, whereas before, the iteration stopped after reading in the
iomap inline extent. This leads erofs to end up in the situation where
it calls into iomap_adjust_read_range() with a non-block-aligned
position/length (on that subsequent iteration).

In particular, this change in commit bc264fea0f6f to iomap_iter():

-       if (ret > 0 && !iter->processed && !stale)
+       if (ret > 0 && !advanced && !stale)

For iomap inline extents, iter->processed is 0, which stopped the
iteration before. But now, advanced (which is iter->pos -
iter->iter_start_pos) is used which will continue the iteration (since
the iter is advanced after reading in the iomap inline extents).

Erofs is able to handle subsequent iterations after iomap_inline
extents because erofs_iomap_begin() checks the block map and returns
IOMAP_HOLE if it's not mapped
        if (!(map.m_flags & EROFS_MAP_MAPPED)) {
                iomap->type =3D IOMAP_HOLE;
                return 0;
        }

but I think what probably would be better is a separate patch that
reverts this back to the original behavior of stopping the iteration
after IOMAP_INLINE extents are read in.

So I don't think this patch should have a fixes: tag for that commit.
It seems to me like no one was hitting this path before with a
non-block-aligned position and offset. Though now there will be a use
case for it, which is fuse.

Thanks,
Joanne

>
> Thanks,
> Joanne
>
> >
> > Also see my reply:
> > https://lore.kernel.org/r/cff53c73-f050-44e2-9c61-96552c0e85ab@linux.al=
ibaba.com
> >
> > I'm not sure if it caused user-visible regressions since
> > erofs images work properly with upstream code (unlike a
> > previous regression fixed by commit b26816b4e320 ("iomap:
> > fix inline data on buffered read")).
> >
> > But a fixes tag is needed since it causes an unexpected
> > WARNING at least.
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > Thanks,
> > > Joanne
> > >
> > > [1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-jo=
annelkoong@gmail.com/T/#t
> > > [2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-jo=
annelkoong@gmail.com/
> > > [3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-jo=
annelkoong@gmail.com/T/#m4ce4707bf98077cde4d1d4845425de30cf2b00f6
> > >
> > >>
> > >> I feel strange why pos is unaligned, does this warning show
> > >> without your patchset on your side?
> > >>
> > >> Thanks,
> > >> Gao Xiang
> > >>
> > >>>
> > >>> Thanks,
> > >>> Joanne
> > >>>
> > >>> [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606b=
ef
> > >>> [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.=
04fc.GAE@google.com/
> > >>>
> > >>>>
> > >>>> Thanks,
> > >>>> Gao Xiang
> > >>>>
> > >>>>>
> > >>>>>
> > >>>>> Thanks,
> > >>>>> Joanne
> > >>>>>
> > >>>>>>
> > >>>>>> Otherwise looks good:
> > >>>>>>
> > >>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> > >>>>
> > >>
> >


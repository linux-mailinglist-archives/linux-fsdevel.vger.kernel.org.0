Return-Path: <linux-fsdevel+bounces-51076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EEBAD2A5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 01:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DA13B210F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 23:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDA1229B07;
	Mon,  9 Jun 2025 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImAxvwx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760620E6E2;
	Mon,  9 Jun 2025 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749510941; cv=none; b=ItqoC54tDkYiYBrW1MQFLXGNyz5iN5wZoU2RVeEmDnrVbTHNr1tRT+oXxnejIYYlLphELcERqoOB3Ss1K+ne6FgdKtsesCS8ObpJccGIYtIPcFczK35reydN+pcan7UgC6Y74Qm+d5Y4pNhT80PpDeZC03YJrUNYXoXjuNHI/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749510941; c=relaxed/simple;
	bh=PXWRWbQfNfa4/a7YKwd3qVVjpm1sTYjTLpXnKiubNMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoFd67PZNTBRBIvw2LHSNvFcP1kAwxJEoHeU52lQX3w5mO3LAIJMkbmpvWy2CMXJfSY8iSA5DTL8KY/0Pg4SNfALF24r1sSJorv/ysP7rlUhHmbyXJNglCtWFAQpHaXtBZG2QBExRDnHSUOlJFIh6C/eR94UlUO82GHAHabjlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImAxvwx9; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a43972dcd7so63597321cf.3;
        Mon, 09 Jun 2025 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749510938; x=1750115738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t649DObLtRdZzX63ptZdq6lquSxzZHNBUYbcq8ILXMQ=;
        b=ImAxvwx9E3bYc3COFhEffAZcRmJCrNFGShpMyHcfmveqnQrnIUtNoiJEhz2Kp0Q5+k
         J82RNTMM0wSHEQ7PGrj6JWYtmNO8Ac3lb2vTpMG+CchEOLqBm2AZdUHrx4lVddDOJu4m
         vzuiVAaFnMGUWqwmo1GAQZ29ccIAAIj4oEeRimEXPqyE+wE3z8XIk7e1k8lA+j/YSds3
         +ymZ0H947c6vOI0fMgzXgu09ggpSp1yQ3Nkfa4XDHAU7HBYymhTi2iCBC9Cp5Xn6U8sx
         adqkja7btt+TbL7n/tIg5wi+C3HWN70h8P3rIkyiH8I/reP3X03u5lgPZI3v3/KzcWTr
         KXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749510938; x=1750115738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t649DObLtRdZzX63ptZdq6lquSxzZHNBUYbcq8ILXMQ=;
        b=OAwu5NIj94/1sRYcsgyaVEewSB3747a1r+zAWDhaZD0E/6OSs8a6vYTv82z9tb7VSl
         emaZnh6pCOSRoX+33ZtN40yr0QXubNk0GO0NRhYMMk7CgwNBsyV9EyNr+O2ixtLMuowI
         EoyWvXEp7bH0LGxbzR+QoFAIZcJmRgrsX61P05Kjfb4vxym0/Bp3S4C+RB+uBKa0PKgA
         9LHynb1eMXIdq6yx5vdfSMpkv0QnWNahX5sxLxFeiw6kq1LEpOhxOWMEi0xyIo76qtNm
         tZLL7ZR57NuxK9eKpMqfc182nfKyxSWUmsHoOTABeqPVVx30Pa4ngWGfmCFDW/oJlwZx
         YptQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe0koivjo6COtQ9Iz3TETtdPxeSUjCGAQXwis6aOLwYtcnRIPP/QZgTMZAP3doeHGbF2T7hiIadMIr6hfk@vger.kernel.org, AJvYcCXkwpfKrCJHbtqM7jUujZem70B5TdXREfI04DuF9ZilsssfsLNGJC4cIngyJix9KfygJY43MNFz5hiH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx82zxtDxgZLrUmNjX2T6WC+vW4A5dLFL88TwaECaoQDcZOJoKt
	mcAP72U8XmCi25ZGnYSE2QvAcoVtBGAIseG3AaWMOGSz+1/pGKK7gbx7M9IYeEaNdJp71s3lfWI
	za06qsgjJZvp/uoVw3MgGFTQgPInvnMY=
X-Gm-Gg: ASbGncuZitBuktbDf/3T4DlWO+NGV6g6FzeIIWksKBhmUQp7h+/8DuX0+B/Qa+LcsSu
	caQyrmOPvqLlooqnHwTk2ndGem1CXgPIFtK0kJaa+ves68F80CYIGli6N+uB9tWF+FKrSTzm+Mu
	vK5C1RqyNk5bJmeyEyg41HeOKTtGtbVKqqh7cQcwzxaYtMv9bpQBifgw==
X-Google-Smtp-Source: AGHT+IHhXThkcANd7gCCQnIgvuOyrZSwuv5O9GNInZFwVo1w3jPutzbzrn+95UWk2++sDvmqtXJR3Ih7VX7uyK2Cse0=
X-Received: by 2002:a05:622a:5a95:b0:476:949b:8c5e with SMTP id
 d75a77b69052e-4a5b9e4df64mr276072811cf.27.1749510938514; Mon, 09 Jun 2025
 16:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-5-joannelkoong@gmail.com> <aEZx5FKK13v36wRv@infradead.org>
In-Reply-To: <aEZx5FKK13v36wRv@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Jun 2025 16:15:27 -0700
X-Gm-Features: AX0GCFsn665UwNgeg9b7whOFgN7cwbYyDPPF26Se9fo_dpmhtO8_lJBaKCr8yqU
Message-ID: <CAJnrk1ZuuE9HKa0OWRjrt6qaPvP5R4DTPBA90PV8M3ke+zqNnw@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] iomap: add writepages support for IOMAP_IN_MEM iomaps
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 10:32=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Jun 06, 2025 at 04:37:59PM -0700, Joanne Koong wrote:
> > This allows IOMAP_IN_MEM iomaps to use iomap_writepages() for handling
> > writeback. This lets IOMAP_IN_MEM iomaps use some of the internal
> > features in iomaps such as granular dirty tracking for large folios.
> >
> > This introduces a new iomap_writeback_ops callback, writeback_folio(),
> > callers may pass in which hands off folio writeback logic to the caller
> > for writing back dirty pages instead of relying on mapping blocks.
> >
> > This exposes two apis, iomap_start_folio_write() and
> > iomap_finish_folio_write(), which callers may find useful in their
> > writeback_folio() callback implementation.
>
> It might also be worth stating what you don't use.  One big thing
> that springs to mind is ioends.  Which are really useful if you
> need more than one request to handle a folio, something that is
> pretty common in network file systems.  I guess you don't need
> that for fuse?

ioends are used in fuse for cleaning up state. fuse implements a
->submit_ioend() callback in fuse_iomap_submit_ioend() (in patch 7/8).

For fuse, there can be multiple requests handling a folio. I'm using
the ifs->write_bytes_pending to keep track of how many requests for
the folio there are, so that we know when to end writeback after the
last request on that folio has completed.

>
> > +     if (wpc->iomap.type =3D=3D IOMAP_IN_MEM) {
> > +             if (wpc->ops->submit_ioend)
> > +                     error =3D wpc->ops->submit_ioend(wpc, error);
> > +             return error;
> > +     }
>
> Given that the patch that moved things around already wrapped the
> error propagation to the bio into a helpr, how does this differ
> from the main path in the function now?
>

If we don't add this special casing for IOMAP_IN_MEM here, then in
this function it'll hit the "if (!wpc->ioend)" case right in the
beginning and return error without calling the ->submit_ioend()
callback. For non IOMAP_IN_MEM types, ->submit_ioend() should only get
called if wpc->ioend is set.

> > +     /*
> > +      * If error is non-zero, it means that we have a situation where =
some part of
> > +      * the submission process has failed after we've marked pages for=
 writeback.
> > +      * We cannot cancel ioend directly in that case, so call the bio =
end I/O handler
> > +      * with the error status here to run the normal I/O completion ha=
ndler to clear
> > +      * the writeback bit and let the file system process the errors.
> > +      */
>
> Please add the comment in a separate preparation patch.

This isn't a new comment, it's just moved from the function
description to here. I'll put this comment move into the patch that
moves all the bio stuff.
>
> > +             if (wpc->ops->writeback_folio) {
> > +                     WARN_ON_ONCE(wpc->ops->map_blocks);
> > +                     error =3D wpc->ops->writeback_folio(wpc, folio, i=
node,
> > +                                                       offset_in_folio=
(folio, pos),
> > +                                                       rlen);
> > +             } else {
> > +                     WARN_ON_ONCE(wpc->iomap.type =3D=3D IOMAP_IN_MEM)=
;
> > +                     error =3D iomap_writepage_map_blocks(wpc, wbc, fo=
lio,
> > +                                                        inode, pos, en=
d_pos,
> > +                                                        rlen, &count);
> > +             }
>
> So instead of having two entirely different methods, can we
> refactor the block based code to also use
> ->writeback_folio?
>
> Basically move all of the code inside the do { } while loop after
> the call into ->map_blocks into a helper, and then let the caller
> loop and also directly discard the folio if needed.  I can give that
> a spin if you want.
>

Sounds great, I like this idea a lot. I'll make this change for v2.

> Note that writeback_folio is misnamed, as it doesn't write back an
> entire folio, but just a dirty range.

I'll rename this to writeback_folio_dirty_range().

>
> >       } else {
> > -             if (!count)
> > +             /*
> > +              * If wpc->ops->writeback_folio is set, then it is respon=
sible
> > +              * for ending the writeback itself.
> > +              */
> > +             if (!count && !wpc->ops->writeback_folio)
> >                       folio_end_writeback(folio);
>
> This fails to explain why writeback_folio does the unlocking itself.

writeback_folio needs to do the unlocking itself because the writeback
may be done asynchronously (as in the case for fuse). I'll add that as
a comment in v2.

> I also don't see how that would work in case of multiple dirty ranges.

For multiple dirty ranges in the same folio, the caller uses
ifs->writes_bytes_pending (through the
iomap_{start/finish}_folio_write() apis) to track when writeback is
finally finished on the folio and folio_end_write() may be called.

>
> >       }
> >       mapping_set_error(inode->i_mapping, error);
> > @@ -1693,3 +1713,25 @@ iomap_writepages(struct address_space *mapping, =
struct writeback_control *wbc,
> >       return iomap_submit_ioend(wpc, error);
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_writepages);
> > +
> > +void iomap_start_folio_write(struct inode *inode, struct folio *folio,=
 size_t len)
> > +{
> > +     struct iomap_folio_state *ifs =3D folio->private;
> > +
> > +     WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
> > +     if (ifs)
> > +             atomic_add(len, &ifs->write_bytes_pending);
> > +}
> > +EXPORT_SYMBOL_GPL(iomap_start_folio_write);
> > +
> > +void iomap_finish_folio_write(struct inode *inode, struct folio *folio=
, size_t len)
> > +{
> > +     struct iomap_folio_state *ifs =3D folio->private;
> > +
> > +     WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
> > +     WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <=3D 0=
);
> > +
> > +     if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
> > +             folio_end_writeback(folio);
>
> Please also use these helpers in the block based code.

Will do. Thanks for your reviews on this.
>


Return-Path: <linux-fsdevel+bounces-46490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D394BA8A385
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 17:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2386F190035A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA346214210;
	Tue, 15 Apr 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCuqIDnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4919F13B
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732789; cv=none; b=K6spd2n/vsSAI8L1XmBbJGK1uLy+CNNJadFvMXJJULFX/Ilq3p+qkydF5Wniw/kgy/hGwxkVRprHQmXAbWmzBl2UUymYg40IBWPXRudiDoo0hQFRBsV8+oCNFF4WM9OL4yWw1Xm/pXrpaZoKU3tWY2zudfncBHEH0Li8fYjBmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732789; c=relaxed/simple;
	bh=qjoiAgy0W3H3EhHFYqhu01KLcy1dGnOGFtbaQFWvcYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJycMao/DT+2cs9eCYleCwYzqlk+bVzid4BbqJoaqAvPlG7vrYGT49Z8v/rKdzdi98nq+CbzmvFsN8Nzodf5Trj9jcXsDL38eh9FFNB0W7xKjDfg0/d/ZWoyI22yuv8lVHfXbR8p06Likreo1G2S/4nhcXI+37rxnA1L6MqUMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCuqIDnT; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4775ccf3e56so70391831cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744732786; x=1745337586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arh8IkZ87TlXMPTVH/FNxuR9f4DY9b3/C3NAqBFAa9c=;
        b=JCuqIDnTbQMJQOWZ2VSqCaZKudFQkDSP51tba3MoQyFalFF6k/za6jHTZD12uQzKkv
         bvG9GqFH33lHvpGVR0pwh7C2KS/nM1sLRO/9wJY5B9RKOGgc6tuAgxDebniC55a7HRdJ
         EwpJBChkYkoBPjLRfrCQq7uEdqFmcIdFU8a2aIYqkMO9A8IEKm+9doYd3B/YJ0dA12r4
         V3GdK2+ljlzVAFX2rJIAPAdTPHST00Jml0I26ec2XeC7GZB6POBfGF9N4E1yO58fJmn4
         gOrCNnXT1siOOVWZmf+81gZ6IfCh+P90Zpo/4p/XX227A2eBQKmYNCmeil/bhsVUBbg4
         J5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744732786; x=1745337586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arh8IkZ87TlXMPTVH/FNxuR9f4DY9b3/C3NAqBFAa9c=;
        b=DU2XcIu7zPlXUkJqmq9F8XMPl5+W7LG2MCdeEVlFwamYAyQHo5n8RG0H6zq5E6EoWY
         oc6XBlxsTlA5tREF54wM0nQhcq3OxmPel31zls6fQF4mQlpxjXDNFN21RH9C0un+IBGb
         RL7QdHdz4wFEgrO/J8kODFdt/HvdSnV/RMzzFNZp2NnbIPMt3CVsIGXsHSC4ZslH/mv8
         4FYAsa2rNzfrni2e7NCrkcc9huyHWDu7BWdZDklwwlsvHKG4qY1jTGI89aoLHckmKruk
         sIeLUyYmKvo+K61Iynt9fx8uAsHQtDROWWrMLPi1YH4dlq0ylAIdeazAl3YM/jibKVHx
         Y/7A==
X-Forwarded-Encrypted: i=1; AJvYcCUcQb6zaNbpVZeu1J2oHd7BZ0rUUGv9KbWSEsm+yckVokt4g7GE4wFcHJ+JjRyzVS5aa1/YGn43Jhr/UPU9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+rlyNLTdzsdlzbnsJ0NJ3SGxXLZsE8UqR0DtrZP5J8Dd9ziX
	mMFPLEcd/vEd9bRlqwfEVyJXM+dk3/7RJkS5MVNBZsTs9JjcYvA8oyxFhBQ3N0gSzK2O4s8RXkM
	EtWxtUPEYhbpWKljEPi4s/r+Fsf4=
X-Gm-Gg: ASbGncst6xvkZrtEi7H3tam8kTnfDt8MGpIjVF58UlrSTNCQHhewDrByyb4vmkSP2a1
	40lu5eLTPuYE4rFTSY4NU7/rtB+U3PbvttJcoj4KtuHbZcI/iz1Lha3Ze8C8ZlQv6L0PY4DQ9ao
	O/dpYOfvcxaEfgAIiGaYgmEco9U2N7PB/Jj9IbJg==
X-Google-Smtp-Source: AGHT+IGtKI5ZMHMn2uAXp0tTyih3ObFA9uINH2KRKQ3F2B3zr+7NjUkRrsiPjeL8d27TgFKXRCjLJX8GQyMo/0AMIJ4=
X-Received: by 2002:ac8:590f:0:b0:477:6e32:aae2 with SMTP id
 d75a77b69052e-47ad34dce36mr1156381cf.0.1744732786110; Tue, 15 Apr 2025
 08:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-4-joannelkoong@gmail.com> <db4f1411-f6de-4206-a6a3-5c9cf6b6d59d@linux.alibaba.com>
 <CAJnrk1bTGFXy+ZTchC7p4OYUnbfKZ7TtVkCsrsv87Mg1r8KkGA@mail.gmail.com>
 <7e9b1a40-4708-42a8-b8fc-44fa50227e5b@linux.alibaba.com> <CAJnrk1Z7Wi_KPe_TJckpYUVhv9mKX=-YTwaoQRgjT2z0fxD-7g@mail.gmail.com>
 <9a3cfb55-faae-4551-9bef-b9650432848a@linux.alibaba.com> <CAJnrk1a_YL-Dg4HeVWnmwUVH2tCN2MYu30kiV5KSv4mkezWOZg@mail.gmail.com>
 <a738a765-a5e1-44bc-b1cd-e1a42d73e255@linux.alibaba.com>
In-Reply-To: <a738a765-a5e1-44bc-b1cd-e1a42d73e255@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 15 Apr 2025 08:59:34 -0700
X-Gm-Features: ATxdqUHM-7cPRPuM5ineWxM-iffBsxHZuzqztvNExJta1io3pILv8v00sqSnPXE
Message-ID: <CAJnrk1ZZ7tRwPk0hUePDVcwKnec96qFkO3Mk1zyG2g5PO1XL=w@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev, 
	david@redhat.com, bernd.schubert@fastmail.fm, ziy@nvidia.com, 
	jlayton@kernel.org, kernel-team@meta.com, 
	Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 12:49=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
>
> Hi Joanne,
>
> Sorry for the late reply...

Hi Jingbo,

No worries at all.
>
>
> On 4/11/25 12:11 AM, Joanne Koong wrote:
> > On Thu, Apr 10, 2025 at 8:11=E2=80=AFAM Jingbo Xu <jefflexu@linux.aliba=
ba.com> wrote:
> >>
> >> On 4/10/25 11:07 PM, Joanne Koong wrote:
> >>> On Wed, Apr 9, 2025 at 7:12=E2=80=AFPM Jingbo Xu <jefflexu@linux.alib=
aba.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 4/10/25 7:47 AM, Joanne Koong wrote:
> >>>>>   On Tue, Apr 8, 2025 at 7:43=E2=80=AFPM Jingbo Xu <jefflexu@linux.=
alibaba.com> wrote:
> >>>>>>
> >>>>>> Hi Joanne,
> >>>>>>
> >>>>>> On 4/5/25 2:14 AM, Joanne Koong wrote:
> >>>>>>> In the current FUSE writeback design (see commit 3be5a52b30aa
> >>>>>>> ("fuse: support writable mmap")), a temp page is allocated for ev=
ery
> >>>>>>> dirty page to be written back, the contents of the dirty page are=
 copied over
> >>>>>>> to the temp page, and the temp page gets handed to the server to =
write back.
> >>>>>>>
> >>>>>>> This is done so that writeback may be immediately cleared on the =
dirty page,
> >>>>>>> and this in turn is done in order to mitigate the following deadl=
ock scenario
> >>>>>>> that may arise if reclaim waits on writeback on the dirty page to=
 complete:
> >>>>>>> * single-threaded FUSE server is in the middle of handling a requ=
est
> >>>>>>>   that needs a memory allocation
> >>>>>>> * memory allocation triggers direct reclaim
> >>>>>>> * direct reclaim waits on a folio under writeback
> >>>>>>> * the FUSE server can't write back the folio since it's stuck in
> >>>>>>>   direct reclaim
> >>>>>>>
> >>>>>>> With a recent change that added AS_WRITEBACK_INDETERMINATE and mi=
tigates
> >>>>>>> the situations described above, FUSE writeback does not need to u=
se
> >>>>>>> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode map=
pings.
> >>>>>>>
> >>>>>>> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
> >>>>>>> and removes the temporary pages + extra copying and the internal =
rb
> >>>>>>> tree.
> >>>>>>>
> >>>>>>> fio benchmarks --
> >>>>>>> (using averages observed from 10 runs, throwing away outliers)
> >>>>>>>
> >>>>>>> Setup:
> >>>>>>> sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
> >>>>>>>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threa=
ds=3D4 -o source=3D~/tmp_mount ~/fuse_mount
> >>>>>>>
> >>>>>>> fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1k,=
4k,1M} --size=3D2G
> >>>>>>> --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --directory=
=3D/root/fuse_mount
> >>>>>>>
> >>>>>>>         bs =3D  1k          4k            1M
> >>>>>>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> >>>>>>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
> >>>>>>> % diff        -3%          23%         45%
> >>>>>>>
> >>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>>>>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> >>>>>>> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> >>>>>>
> >>>>>
> >>>>> Hi Jingbo,
> >>>>>
> >>>>> Thanks for sharing your analysis for this.
> >>>>>
> >>>>>> Overall this patch LGTM.
> >>>>>>
> >>>>>> Apart from that, IMO the fi->writectr and fi->queued_writes mechan=
ism is
> >>>>>> also unneeded then, at least the DIRECT IO routine (i.e.
> >>>>>
> >>>>> I took a look at fi->writectr and fi->queued_writes and my
> >>>>> understanding is that we do still need this. For example, for
> >>>>> truncates (I'm looking at fuse_do_setattr()), I think we still need=
 to
> >>>>> prevent concurrent writeback or else the setattr request and the
> >>>>> writeback request could race which would result in a mismatch betwe=
en
> >>>>> the file's reported size and the actual data written to disk.
> >>>>
> >>>> I haven't looked into the truncate routine yet.  I will see it later=
.
> >>>>
> >>>>>
> >>>>>> fuse_direct_io()) doesn't need fuse_sync_writes() anymore.  That i=
s
> >>>>>> because after removing the temp page, the DIRECT IO routine has al=
ready
> >>>>>> been waiting for all inflight WRITE requests, see
> >>>>>>
> >>>>>> # DIRECT read
> >>>>>> generic_file_read_iter
> >>>>>>   kiocb_write_and_wait
> >>>>>>     filemap_write_and_wait_range
> >>>>>
> >>>>> Where do you see generic_file_read_iter() getting called for direct=
 io reads?
> >>>>
> >>>> # DIRECT read
> >>>> fuse_file_read_iter
> >>>>   fuse_cache_read_iter
> >>>>     generic_file_read_iter
> >>>>       kiocb_write_and_wait
> >>>>        filemap_write_and_wait_range
> >>>>       a_ops->direct_IO(),i.e. fuse_direct_IO()
> >>>>
> >>>
> >>> Oh I see, I thought files opened with O_DIRECT automatically call the
> >>> .direct_IO handler for reads/writes but you're right, it first goes
> >>> through .read_iter / .write_iter handlers, and the .direct_IO handler
> >>> only gets invoked through generic_file_read_iter() /
> >>> generic_file_direct_write() in mm/filemap.c
> >>>
> >>> There's two paths for direct io in FUSE:
> >>> a) fuse server sets fi->direct_io =3D true when a file is opened, whi=
ch
> >>> will set the FOPEN_DIRECT_IO bit in ff->open_flags on the kernel side
> >>> b) fuse server doesn't set fi->direct_io =3D true, but the client ope=
ns
> >>> the file with O_DIRECT
> >>>
> >>> We only go through the stack trace you listed above for the b) case.
> >>> For the a) case, we'll hit
> >>>
> >>>         if (ff->open_flags & FOPEN_DIRECT_IO)
> >>>                 return fuse_direct_read_iter(iocb, to);
> >>>
> >>> and
> >>>
> >>>         if (ff->open_flags & FOPEN_DIRECT_IO)
> >>>                 return fuse_direct_write_iter(iocb, from);
> >>>
> >>> which will invoke fuse_direct_IO() / fuse_direct_io() without going
> >>> through the kiocb_write_and_wait() -> filemap_write_and_wait_range() =
/
> >>> kiocb_invalidate_pages() -> filemap_write_and_wait_range() you listed
> >>> above.
> >>>
> >>> So for the a) case I think we'd still need the fuse_sync_writes() in
> >>> case there's still pending writeback.
> >>>
> >>> Do you agree with this analysis or am I missing something here?
> >>
> >> Yeah, that's true.  But instead of calling fuse_sync_writes(), we can
> >> call filemap_wait_range() or something similar here.
> >>
> >
> > Agreed. Actually, the more I look at this, the more I think we can
> > replace all fuse_sync_writes() and get rid of it entirely.
>
>
> I have seen your latest reply that this cleaning up won't be included in
> this series, which is okay.
>
>
> > fuse_sync_writes() is called in:
> >
> > fuse_fsync():
> >         /*
> >          * Start writeback against all dirty pages of the inode, then
> >          * wait for all outstanding writes, before sending the FSYNC
> >          * request.
> >          */
> >         err =3D file_write_and_wait_range(file, start, end);
> >         if (err)
> >                 goto out;
> >
> >         fuse_sync_writes(inode);
> >
> >         /*
> >          * Due to implementation of fuse writeback
> >          * file_write_and_wait_range() does not catch errors.
> >          * We have to do this directly after fuse_sync_writes()
> >          */
> >         err =3D file_check_and_advance_wb_err(file);
> >         if (err)
> >                 goto out;
> >
> >
> >       We can get rid of the fuse_sync_writes() and
> > file_check_and_advance_wb_err() entirely since now without temp pages,
> > the file_write_and_wait_range() call actually ensures that writeback
> > is completed
> >
> >
> >
> > fuse_writeback_range():
> >         static int fuse_writeback_range(struct inode *inode, loff_t
> > start, loff_t end)
> >         {
> >                 int err =3D
> > filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
> >
> >                 if (!err)
> >                         fuse_sync_writes(inode);
> >
> >                 return err;
> >         }
> >
> >
> >       We can replace fuse_writeback_range() entirely with
> > filemap_write_and_wait_range().
> >
> >
> >
> > fuse_direct_io():
> >         if (fopen_direct_io && fc->direct_io_allow_mmap) {
> >                 res =3D filemap_write_and_wait_range(mapping, pos, pos =
+
> > count - 1);
> >                 if (res) {
> >                         fuse_io_free(ia);
> >                         return res;
> >                 }
> >         }
> >         if (!cuse && filemap_range_has_writeback(mapping, pos, (pos +
> > count - 1))) {
> >                 if (!write)
> >                         inode_lock(inode);
> >                 fuse_sync_writes(inode);
> >                 if (!write)
> >                         inode_unlock(inode);
> >         }
> >
> >
> >        I think this can just replaced with
> >                 if (fopen_direct_io && (fc->direct_io_allow_mmap || !cu=
se)) {
> >                         res =3D filemap_write_and_wait_range(mapping,
> > pos, pos + count - 1);
> >                         if (res) {
> >                                 fuse_io_free(ia);
> >                                 return res;
> >                         }
> >                 }
>
> Alright. But I would prefer doing this filemap_write_and_wait_range() in
> fuse_direct_write_iter() rather than fuse_direct_io() if possible.
>
> >        since for the !fopen_direct_io case, it will already go through
> > filemap_write_and_wait_range(), as you mentioned in your previous
> > message. I think this also fixes a bug (?) in the original code - in
> > the fopen_direct_io && !fc->direct_io_allow_mmap case, I think we
> > still need to write out dirty pages first, which we don't currently
> > do.
>
> Nope.  In case of fopen_direct_io && !fc->direct_io_allow_mmap, there
> won't be any page cache at all, right?
>

Isn't there still a page cache if the file was previously opened
without direct io and then the client opens another handle to that
file with direct io? In that case, the pages could still be dirty in
the page cache and would need to be written back first, no?


Thanks,
Joanne
>
>
> --
> Thanks,
> Jingbo


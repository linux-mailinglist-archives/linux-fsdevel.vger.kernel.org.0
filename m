Return-Path: <linux-fsdevel+bounces-48531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA64EAB0A9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 08:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8969E4478
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 06:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B80F26AA8C;
	Fri,  9 May 2025 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Y+EO67ww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615BB18DF8D;
	Fri,  9 May 2025 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746772415; cv=none; b=m4NgnBQ94iyugg8Dvczyya5UKIe8SWCPP/n1z1lRl3t4tGFL+Syrj4F3dqt0e+qI03LE0Qv70lEl/Ho275mToEWV5vwh6VB4i5UuwQK8RKqKESL0m6oDAXBiYLNKIXBOKvzod1UevJYEdcLBmc4OAUps4LJM5TDQDn+/g+kTllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746772415; c=relaxed/simple;
	bh=q1VuHnmBAKUTGwMGgc3N5hw2C4nls/EI1SF8ovj/i8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cANLM1MT7mtGadyOylrotiQmPUmyMQxBCVrpb5Ch8xkkQiIfbtfJOkUEawoCDQWLkgIyqJn1u5SK6waRZ/bsBNJ+v6s0mqw+SVX8VVpHeCfAE4iTKjF8fds+VQ2xCvmZc+7seAI5e2+Dbqn5gdywFUK4yqcVGK8cgllmBKshLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Y+EO67ww; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746772402;
	bh=8Sde4P3NmdSHu7GmRsuilRbT0XiR7eoFgBXDZ7bhOCM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=Y+EO67wwlyLFDxTG84V/LdfZGHIRwDrPffhEknZQDFYnMf7VFoHSYZzvfgsqihxpp
	 BfW0WKeanndbAC7NTn0DDa1/wMjVnvOkkRAWzjEEZ0jSx8hdb7iK0ajxr89CXB+Ifn
	 xsdKOdTMLzDAlFf4afBiaTnd++v+6rVLdRKMLaEc=
X-QQ-mid: zesmtpgz3t1746772399t3cad1fa4
X-QQ-Originating-IP: MC8JHiQFjmGk2TyrIx5uf3VJn509W5BNMe5ylKvzWHs=
Received: from mail-yb1-f176.google.com ( [209.85.219.176])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 14:33:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1267821314054948638
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e732386e4b7so1840935276.1;
        Thu, 08 May 2025 23:33:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+ZbtgQz9aYQl/fBSzPBGFBmBhFSsPUOiA1x2ZJP0Eh9aweI2rht205ntdVcQQKGsUdGldmrQQLBpggYDR@vger.kernel.org, AJvYcCUAcjMkjXiXoBhW1/jTStLD1FQdj4zv30I766t2619U+gmvuT53H1QL99cRRqL3IYqJMILEjnZFrcpyjPU5@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWjUeDvAaj8CvoyWBFTj1WXyhjJWf+QkL8NwEgO6sMcdM09ha
	3kU/QpiQNXTnUVPp5G2Wy4UqD/GtXnNarhzR6gwIOPhO4hJe7eOnDxOBXhKFE5pccXp9QVMYTwc
	w5ve+bBqkzHe1g4MtHkf9C/AL0Bk=
X-Google-Smtp-Source: AGHT+IHCIUY3+iCrTZGHOGeMlLvNk6sXIQJ3KRjrCTo9W8vfLyhdjkyNRIFC571Yt5DTSV1am0vU0Ini2FVweiOHnvA=
X-Received: by 2002:a05:6902:2843:b0:e78:f3d5:d18e with SMTP id
 3f1490d57ef6-e78fdc710bdmr2946216276.21.1746772396836; Thu, 08 May 2025
 23:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com>
 <20250508-fusectl-backing-files-v2-2-62f564e76984@uniontech.com> <CAOQ4uxjLkpUz2BPwVUtk6zHQtYmVww9qkUtGi5YA=Y-9XeiU9w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjLkpUz2BPwVUtk6zHQtYmVww9qkUtGi5YA=Y-9XeiU9w@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Fri, 9 May 2025 14:33:05 +0800
X-Gmail-Original-Message-ID: <E6CFDC2A6D55EDFA+CAC1kPDNC4ZTTMFJYQB9g1XKW4Gk7grkdZUY6KOBOvadGstT9Ug@mail.gmail.com>
X-Gm-Features: ATxdqUFwIoDX0xlYx0_Rbh5a89YYvfAhnytB0BAXCBPtWfQ9w46wii8Q-jqvCZA
Message-ID: <CAC1kPDNC4ZTTMFJYQB9g1XKW4Gk7grkdZUY6KOBOvadGstT9Ug@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fs: fuse: add backing_files control file
To: Amir Goldstein <amir73il@gmail.com>
Cc: chenlinxuan@uniontech.com, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MmpliBmRb3iCFg9xO5fV1ywUsbt5kLcz7055VZx1SFPoWhJXCodHyfEH
	IPlVmDXbgHDI8SGgmStmoG4en4TJBu/ZEYUCIGz0VWHiKZcV+Go1hXIVHW9qs/j0wprd09Q
	891bfcBMw3fvZor2e/I/LsxDs0EIjsbK9pjHpL4zCI4Gu7AoKKsSeT3P9zzUub+KiPV7cuH
	RC6W9XtA/0SOwT+c9btSxxK8kA3qOq1LBf1ncvboxnMc39EWsmA/mN0xJ6lfmwkG3S+KyF7
	G4b0dHXyxMVhR3cpBkgU0mQs6jyCZIQxAlvstkJymDXY9mrZ5GZSGavzjEBYW+7kgXx7esC
	Tp2/M6UwQIPL+DBQI3rT9cOgTs5ny1MT2OtTbVqgd/UW1gvcxASPFMoTe8GDC7apd+QiD4B
	hlzYUJB/5wAVoADh8KGyXVdfN0zs2mWMPPW9Oas2araCpRiadEOmeDM6XoNMvG4b+CBtWOD
	zOkFq/ACHCnEwBAOIFG1q6mNmVuj7aGn3FninAQMg3u5zjE/XImVqWk0TJ62bAxGZ+QY8/z
	6sh5Elyp/sMrmNNc4lxnPI7rDxEPbjNss9bgvb2HWZFI9+ciLM4d/ROLPyLUEr1z+xQlZQX
	h3Ay0xNMDXijHFK865Zsz9Z6MM9zE43coJn9ytsz2MU3plG9mEtlu/HiIFU4Qrnqm9+KzBw
	s3czJxKyWt46L1w/4dDcFw4hvNNK8ThGeHb/9vyG97EvUa8iKcpGWQ76v4xgEBDjxldtdgO
	NVuDPx/WUAKezGzK95BTLHPujKOrRTOXBm2NMduqukYkxqm2gEFWt98fiM6+ccQB/v8l/k2
	e0ThCkJeP4q7166IOyC3sbi4pHYjU8suL62VfiiccY5IahrLzPMFallcgPewQXGbVi2B86X
	oUW4hd3domB9vVVJeYXHVFETx+ZIg2GZCWdy8gziuehYBaSUNmDu1k476CvXR7IXw0OHUmU
	VYpgxGqc6PvFATkqYDzAntIPylhpTsjhxln2Gae+Ui4YFHnq0L2EsqsjpCc81XnOUMTatcA
	qTIlcnghSG4yQ0JV2Ez08jDXq88f7JK4lYFEdogg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Thu, May 8, 2025 at 6:45=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Thu, May 8, 2025 at 10:54=E2=80=AFAM Chen Linxuan via B4 Relay
> <devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
> >
> > From: Chen Linxuan <chenlinxuan@uniontech.com>
> >
> > Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files"
> > that exposes the paths of all backing files currently being used in
> > FUSE mount points. This is particularly valuable for tracking and
> > debugging files used in FUSE passthrough mode.
> >
> > This approach is similar to how fixed files in io_uring expose their
> > status through fdinfo, providing administrators with visibility into
> > backing file usage. By making backing files visible through the FUSE
> > control filesystem, administrators can monitor which files are being
> > used for passthrough operations and can force-close them if needed by
> > aborting the connection.
> >
> > This exposure of backing files information is an important step towards
> > potentially relaxing CAP_SYS_ADMIN requirements for certain passthrough
> > operations in the future, allowing for better security analysis of
> > passthrough usage patterns.
> >
> > The control file is implemented using the seq_file interface for
> > efficient handling of potentially large numbers of backing files.
> > Access permissions are set to read-only (0400) as this is an
> > informational interface.
> >
> > FUSE_CTL_NUM_DENTRIES has been increased from 5 to 6 to accommodate the
> > additional control file.
> >
> > Some related discussions can be found at links below.
> >
> > Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca519@=
fastmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
> > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSufw_=
53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > ---
> >  fs/fuse/control.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  fs/fuse/fuse_i.h  |   2 +-
> >  2 files changed, 136 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> > index f0874403b1f7c91571f38e4ae9f8cebe259f7dd1..d1ac934d7b8949577545ffd=
20535c68a9c4ef90f 100644
> > --- a/fs/fuse/control.c
> > +++ b/fs/fuse/control.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> >  #include <linux/fs_context.h>
> > +#include <linux/seq_file.h>
> >
> >  #define FUSE_CTL_SUPER_MAGIC 0x65735543
> >
> > @@ -180,6 +181,136 @@ static ssize_t fuse_conn_congestion_threshold_wri=
te(struct file *file,
> >         return ret;
> >  }
> >
> > +struct fuse_backing_files_seq_state {
> > +       struct fuse_conn *fc;
> > +       int backing_id;
> > +};
> > +
> > +static void *fuse_backing_files_seq_start(struct seq_file *seq, loff_t=
 *pos)
> > +{
> > +       struct fuse_backing *fb;
> > +       struct fuse_backing_files_seq_state *state;
> > +       struct fuse_conn *fc;
> > +       int backing_id;
> > +       void *ret;
> > +
> > +       if (*pos + 1 > INT_MAX)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       backing_id =3D *pos + 1;
>
> I am not sure if this +1 is correct.
> Please make sure that you test reading in several chunks
> not only from pos 0 to make sure this is right.
> Assuming that is how the code gets to call start() with non zero pos?

I am not very certain.
In seq_file.c, we can see some processes like stop, allocating a new buffer=
,
and restarting at the original pos when the buffer is full.

Without adding this +1, this part of the code actually doesn't work correct=
ly.
It outputs the backing_file with id=3D1 twice.
I think the reason for this issue is that I didn't update the value of
pos with backing_id after calling idr_get_next().

>
> I think that backing_id should always be in sync with *pos for that to
> work correctly.
> "The next() function should set ``*pos`` to a value that start() can use
> to find the new location in the sequence."
>
> That means that we do not really need the backing_id in the state.
> We can just have a local backing_id var that reads from *pos and
> *pos is set to it at the end of start/next.

I think we need to maintain pos in the state
because show() does not accept pos as a parameter.

>
> > +
> > +       fc =3D fuse_ctl_file_conn_get(seq->file);
> > +       if (!fc)
> > +               return ERR_PTR(-ENOTCONN);
> > +
> > +       rcu_read_lock();
> > +
> > +       fb =3D idr_get_next(&fc->backing_files_map, &backing_id);
> > +
> > +       rcu_read_unlock();
> > +
> > +       if (!fb) {
> > +               ret =3D NULL;
> > +               goto err;
> > +       }
> > +
> > +       state =3D kmalloc(sizeof(*state), GFP_KERNEL);
> > +       if (!state) {
> > +               ret =3D ERR_PTR(-ENOMEM);
> > +               goto err;
> > +       }
> > +
> > +       state->fc =3D fc;
> > +       state->backing_id =3D backing_id;
> > +
> > +       ret =3D state;
> > +       return ret;
> > +
> > +err:
> > +       fuse_conn_put(fc);
> > +       return ret;
> > +}
> > +
> > +static void *fuse_backing_files_seq_next(struct seq_file *seq, void *v=
,
> > +                                        loff_t *pos)
> > +{
> > +       struct fuse_backing_files_seq_state *state =3D v;
> > +       struct fuse_backing *fb;
> > +
> > +       (*pos)++;
> > +       state->backing_id++;
>
> Need to check for INT_MAX overflow?

It shouldn't be necessary. Before overflow occurs, idr_get_next() will
already return NULL.

>
> > +
> > +       rcu_read_lock();
> > +
> > +       fb =3D idr_get_next(&state->fc->backing_files_map, &state->back=
ing_id);
> > +
> > +       rcu_read_unlock();
> > +
> > +       if (!fb)
> > +               return NULL;
>
> I think that I gave you the wrong advice on v1 review.
> IIUC, if you return NULL from next(), stop() will get a NULL v arg,
> so I think you need to put fc and free state here as well.
> Please verify that.
>
> Perhaps a small helper fuse_backing_files_seq_state_free()
> can help the code look cleaner, because you may also need it
> in the int overflow case above?
>
> > +
> > +
> > +       return state;
> > +}
> > +
> > +static int fuse_backing_files_seq_show(struct seq_file *seq, void *v)
> > +{
> > +       struct fuse_backing_files_seq_state *state =3D v;
> > +       struct fuse_conn *fc =3D state->fc;
> > +       struct fuse_backing *fb;
> > +
> > +       rcu_read_lock();
> > +
> > +       fb =3D idr_find(&fc->backing_files_map, state->backing_id);
> > +       fb =3D fuse_backing_get(fb);
>
> rcu_read_unlock();
>
> should be here.
> After you get a ref on fb, it is safe to deref fb without RCU
> so no need for the goto cleanup labels.
>
> > +       if (!fb)
> > +               goto out;
> > +
> > +       if (!fb->file)
> > +               goto out_put_fb;
> > +
>
> This would be nicer as
>       if (!fb->file) {
>
> to avoid the goto.

I guess what you meant to say was if (fb->file)?

>
> > +       seq_printf(seq, "%5u: ", state->backing_id);
> > +       seq_file_path(seq, fb->file, " \t\n\\");
> > +       seq_puts(seq, "\n");
> > +
> > +out_put_fb:
> > +       fuse_backing_put(fb);
> > +out:
> > +       rcu_read_unlock();
> > +       return 0;
> > +}
> > +
> > +static void fuse_backing_files_seq_stop(struct seq_file *seq, void *v)
> > +{
> > +       struct fuse_backing_files_seq_state *state;
> > +
> > +       if (!v)
> > +               return;
> > +
> > +       state =3D v;
> > +       fuse_conn_put(state->fc);
> > +       kvfree(state);
>
> That could become a helper
> static void fuse_backing_files_seq_state_free(struct
> fuse_backing_files_seq_state *state)
>
> and seq_stop() could become:
>
> if (v)
>        fuse_backing_files_seq_state_free(v);
>
>
> Thanks,
> Amir.
>
>

I will send the next version of the patch later.


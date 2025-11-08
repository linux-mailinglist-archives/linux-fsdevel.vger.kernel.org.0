Return-Path: <linux-fsdevel+bounces-67521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B4C42202
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 01:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7848C34EB4B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 00:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201FE20B212;
	Sat,  8 Nov 2025 00:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqJveofv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA48615A;
	Sat,  8 Nov 2025 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762561453; cv=none; b=Jc892Oplc7CPMtgV/FQP/tUv+jMr2cOY5W7zveGPkADiHBYtG4MKz84Da25C3By1pRieke4OeIfqsdZ3k2ZthwVqxv1Kkm529g3aZdLoTrCdyQPvttfx9ZsgckT6zz/X503rYXcjM/zPR6BW2OPWqnlltV2WK6GQ92SzA0U8EE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762561453; c=relaxed/simple;
	bh=NfbaMC1fml+IcsM5El8WNVSqIe3UXf1ZuroAWdV+qek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYzUxWN2dfjbf4F0oQx3GWTtJ4Dhxfj8bUqUOZsEQ2/84mv4InZWBPb0X3RVz0eW3AwXFo0b4uON2DjqvVfA9ngQSqkIKSbSLdE1uNtg9p/Txkkq+ZOAACK5SjbD8uHf5EVMIw553mpxSc6mrDREQYvra43TGHK9JzYL0Ivw9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqJveofv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC420C4CEF7;
	Sat,  8 Nov 2025 00:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762561452;
	bh=NfbaMC1fml+IcsM5El8WNVSqIe3UXf1ZuroAWdV+qek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VqJveofvG4sJ7UTyX4hNwCkbG0UG8kMk9udUjn/+/z/S3U58chFW++3/1xx5EzJ4R
	 DTouCQbn9zJjiviwQDGYB7ewZKldr9vk49IUc7nGtUhm70EEJEdZfx/wbT8f2+4hpz
	 X/GHmR/zasOViWZe8Ag40xB95ICgEXM8cHnOokbDAI26iy7jHDlLxiPsCftuezZl6+
	 SpYqXsHdo3DG8tqzwLdLSU5ksSw/OkmDUf1yVEnI98KSQz27GJVODwDnikyo+CSI+A
	 n/R+b0NfKnbdECqDcp4nhnhE/0doBMkgI0YBffEXACz9IB4/+b3BEasfnB3Ab7Wz8Z
	 L73nVU59HLKqg==
Date: Fri, 7 Nov 2025 16:24:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fuse_trace: move the passthrough-specific code back
 to passthrough.c
Message-ID: <20251108002412.GM196391@frogsfrogsfrogs>
References: <176169809796.1424693.4820699158982303428.stgit@frogsfrogsfrogs>
 <176169809851.1424693.14006418302806790576.stgit@frogsfrogsfrogs>
 <CAJnrk1YJP9z2k7zy-NyirMV-Rs8md4WF1MSNJOAfKNaB-Lv_yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YJP9z2k7zy-NyirMV-Rs8md4WF1MSNJOAfKNaB-Lv_yg@mail.gmail.com>

On Fri, Nov 07, 2025 at 12:55:39PM -0800, Joanne Koong wrote:
> On Tue, Oct 28, 2025 at 5:44 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Add tracepoints for the previous patch.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_trace.h |   35 +++++++++++++++++++++++++++++++++++
> >  fs/fuse/backing.c    |    5 +++++
> >  2 files changed, 40 insertions(+)
> >
> >
> > diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> > index bbe9ddd8c71696..286a0845dc0898 100644
> > --- a/fs/fuse/fuse_trace.h
> > +++ b/fs/fuse/fuse_trace.h
> > @@ -124,6 +124,41 @@ TRACE_EVENT(fuse_request_end,
> >                   __entry->unique, __entry->len, __entry->error)
> >  );
> >
> > +#ifdef CONFIG_FUSE_BACKING
> > +TRACE_EVENT(fuse_backing_class,
> > +       TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
> > +                const struct fuse_backing *fb),
> > +
> > +       TP_ARGS(fc, idx, fb),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(dev_t,                  connection)
> > +               __field(unsigned int,           idx)
> > +               __field(unsigned long,          ino)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               struct inode *inode = file_inode(fb->file);
> > +
> > +               __entry->connection     =       fc->dev;
> > +               __entry->idx            =       idx;
> > +               __entry->ino            =       inode->i_ino;
> > +       ),
> > +
> > +       TP_printk("connection %u idx %u ino 0x%lx",
> > +                 __entry->connection,
> > +                 __entry->idx,
> > +                 __entry->ino)
> > +);
> > +#define DEFINE_FUSE_BACKING_EVENT(name)                \
> > +DEFINE_EVENT(fuse_backing_class, name,         \
> > +       TP_PROTO(const struct fuse_conn *fc, unsigned int idx, \
> > +                const struct fuse_backing *fb), \
> > +       TP_ARGS(fc, idx, fb))
> > +DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
> > +DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
> > +#endif /* CONFIG_FUSE_BACKING */
> > +
> >  #endif /* _TRACE_FUSE_H */
> >
> >  #undef TRACE_INCLUDE_PATH
> > diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> > index f5efbffd0f456b..b83a3c1b2dff7a 100644
> > --- a/fs/fuse/backing.c
> > +++ b/fs/fuse/backing.c
> > @@ -72,6 +72,7 @@ static int fuse_backing_id_free(int id, void *p, void *data)
> >
> >         WARN_ON_ONCE(refcount_read(&fb->count) != 1);
> >
> > +       trace_fuse_backing_close((struct fuse_conn *)data, id, fb);
> >         fuse_backing_free(fb);
> >         return 0;
> >  }
> > @@ -145,6 +146,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
> >                 fb = NULL;
> >                 goto out;
> >         }
> > +
> > +       trace_fuse_backing_open(fc, res, fb);
> >  out:
> >         pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
> >
> > @@ -194,6 +197,8 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> >         if (err)
> >                 goto out_fb;
> >
> > +       trace_fuse_backing_close(fc, backing_id, fb);
> > +
> 
> If I'm understanding it correctly, the lines above (added from the
> previous patch) are
> 
> + err = ops->may_admin ? ops->may_admin(fc, 0) : 0;
> + if (err)
> +       goto out_fb;
> +
> + err = ops->may_close ? ops->may_close(fc, fb->file) : 0;
> + if (err)
> +        goto out_fb;

That's correct.

> and will also do the close in the out_fb goto. So should the
> trace_fuse_backing_close() be moved to before the "err =
> ops->may_admin..." line so it doesn't get missed in the "if (err)..."
> cases?

No.  If either ->may_admin or ->may_close return nonzero, then this
function drops the active reference to @fb that it obtained from
__fuse_backing_lookup without calling fuse_backing_id_remove.
Therefore, the fuse connection retains its mapping of backing_id to a
fuse_backing object, which means that nothing is closed.

--D

> Thanks,
> Joanne
> 
> >         err = -ENOENT;
> >         test_fb = fuse_backing_id_remove(fc, backing_id);
> >         if (!test_fb)
> >


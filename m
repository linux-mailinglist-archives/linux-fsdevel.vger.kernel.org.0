Return-Path: <linux-fsdevel+bounces-38478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6439BA03157
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 21:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEF13A5930
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 20:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449521E00AF;
	Mon,  6 Jan 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F3rQS6E2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD88C1E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195061; cv=none; b=euOmkWz1zXAYlUFf2RXD5inULVK/L935ToQ2ftqytv3cA98C12ooXx2s+fF4yWSzdd3TYdJ9T/IJtvkNXsZ3tzpFd7wp0vjkcWnHcWCgfwGt/nG2OjoMmo35raN6qNIzjaMK4bViXz3YO8eCvBoq67sBXtYxN0x4pPPR3hOukxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195061; c=relaxed/simple;
	bh=s1wgOcDn7cSpcJ+tH+U844kZ7pg2XdMIU2ANma3RWrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVwJ6nG2gLoMyH6twR3GnioUsw+m616QZLAOHNHKMgRMMXxBgHSzEVcShgkVrMRGfdw8Ls/tamU40kaV1nk7KhnFCxgiyivABY5MSQrUQMhfRm9zECSPzs2udRRsYwXXPLQ1PZUNRQ7AyhOBnVu9b+ozTMZD8kNLv5o8oHN+5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F3rQS6E2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso21775788a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736195057; x=1736799857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DDIt4i68A64KQq+HaE/jzUMqHIv1cju3rvq2raanszM=;
        b=F3rQS6E2uuNk66R3L9Gt61MikmYQa1zsnwP139N5vhWVxe+/1pXKvoTyEyaLLyTv+U
         VE/3mvlwsirOs/hnHaQ4FYIZjYY9LZsocXmE2fD0vsfrsxx8X7yFuZzpbDMDeJSjVRhN
         JQ40WjbhfjQXOl4UpTlWb3pmCygVG9eIgzdvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736195057; x=1736799857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDIt4i68A64KQq+HaE/jzUMqHIv1cju3rvq2raanszM=;
        b=bMDKmitTkddzbqdl6mpIP0Iz0gVrAPDb+n/xcj5YyJpfgRio9EiFAoe9/Vpm394OP7
         VB621r+9pGFyqY/bnCZmfqtfD0M2fsG19+mAZ8ZF0NEDJ9Mhw1vmz7t4cwNmEMIk62M4
         KiUpDDeqIIBL9ZY0xKI/DsXBOQeacRCJcja2oi9OoRsM+/HfQcSIgm54NWzz4dniVUAK
         GEaCuNqp+mR1stT9Vdbu7bBpddI3YY7oRKiOLKwaNLgVhSg25NFtiyZAC4Zp8NkjUeXJ
         CdK6xtVZIBHFefIdMS5WXIEAGa/FcAjo4G3q/DXkEht8gVjYMM21LtfuVMbuxJhPCLa4
         V8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxBwT7fvPNbXDfiURjKis7YeZbkFDhvaTNfxFogSj1CzyeikvgIFKmnelsK7k5reAiJr5JjinLisdEQBMp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ptHtdGhdJnMmIEFkGCKbMU+1HErZvflZCyWPt8eQMC11ozPF
	LTcJhGSGhNLKN+VxD7/z7pXNfHcZC92WR2O3DFnrjApsVc67bL0rtE/OX5pgo02UtzB0UE+9+0N
	FbVE=
X-Gm-Gg: ASbGncvcBW8LEpXmj5CG0wfYA3+NjQ9G5OAzdssCIcZnZ/xPwcYvpcBK6LHU05zr3x3
	lYtgHxSIiLf60oCmXwO+F3p5A3q8p7aQ/qh1LKp+KDtM3DM+ovKsyeKj8nkxYffyZlTT7EdX7QT
	WtHFLEB0eUuKtBh46Gd0X2CRjrMjz2Vnxa1t9Lu3izlc9TdgKrEt64lw9h0gAb5c4/ma3hXcaoV
	x8VIV8NcBhEWr0CwALWhNszWckSkLTrDtWAyIlCyhFC1DsjD0Ng7Vm3cywLRq2WFe8GVaflWKjI
	421hZU+Q0syrEbwYalhG/d+6bTxtrks=
X-Google-Smtp-Source: AGHT+IHMOxyDMMP279NfKmurFGJhL4rPWt72F92cnn26YeeFUJGrqLkQYqYd/lGSYAAXC5+lczOw8Q==
X-Received: by 2002:a17:906:c10b:b0:aa6:9b02:7fd0 with SMTP id a640c23a62f3a-aac2695a396mr5677052666b.0.1736195056523;
        Mon, 06 Jan 2025 12:24:16 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f0128b8sm2298014166b.145.2025.01.06.12.24.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 12:24:16 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e44654ae3so2473051366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 12:24:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmUDv5/V4ryQgsNW9nf0999zSFgK/2Lipu6Ad9cpLsxYmE17FcR29aQrXPMkdADx4AdQxXiB02rm4Pd7tu@vger.kernel.org
X-Received: by 2002:a17:906:f596:b0:aa6:894c:84b7 with SMTP id
 a640c23a62f3a-aac2703396bmr5201651866b.12.1736195055518; Mon, 06 Jan 2025
 12:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241229135737.GA3293@redhat.com> <20250102163320.GA17691@redhat.com>
 <CAHk-=wj9Hr4PBobc13ZEv3HvFfpiZYrWX2-t5F62TXmMJoL5ZA@mail.gmail.com>
 <20250106163038.GE7233@redhat.com> <CAHk-=whZwWJ4dA-r54eyEZaiVpEK+-9joKid3EyPsHVRGAgEgA@mail.gmail.com>
 <20250106183646.GG7233@redhat.com> <20250106193336.GH7233@redhat.com>
In-Reply-To: <20250106193336.GH7233@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Jan 2025 12:23:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-SxjH7uvADd5XJBuM2ReyPcLPyXKvBbwbiS5kod+3hA@mail.gmail.com>
X-Gm-Features: AbW1kvZU3ituzJkj8mJKj3L6Ndcs-M3POYGP1nARDZ7A9e1gedxe26Z8_xxS_Fs
Message-ID: <CAHk-=wh-SxjH7uvADd5XJBuM2ReyPcLPyXKvBbwbiS5kod+3hA@mail.gmail.com>
Subject: Re: wakeup_pipe_readers/writers() && pipe_poll()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 11:34, Oleg Nesterov <oleg@redhat.com> wrote:
>
> 1. pipe_read() says
>
>          * But when we do wake up writers, we do so using a sync wakeup
>          * (WF_SYNC), because we want them to get going and generate more
>          * data for us.
>
> OK, WF_SYNC makes sense if pipe_read() or pipe_write() is going to do wait_event()
> after wake_up(). But wake_up_interruptible_sync_poll() looks at bit misleading if
> we are going to wakeup the writer or next_reader before return.

This heuristic has always been a bit iffy. And honestly, I think it's
been driven by benchmarks that aren't necessarily always realistic (ie
for ping-pong benchmarks, the best behavior is often to stay on the
same CPU and just schedule between the reader/writer).

Those are exactly the kinds that will *not* do wait_event(), because
they just read or wrote a single byte, but doing a "sync" wakeup then
gets you the optimal pattern of "run the other end on the same CPU".

And do those cases exist outside of benchmarks? Probably not.

Ergo: I don't think there's a "right solution".

> 2. I can't understand this code in pipe_write()
>
>         if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
>                 int err = file_update_time(filp);
>                 if (err)
>                         ret = err;
>                 sb_end_write(file_inode(filp)->i_sb);
>         }
>
>         - it only makes sense in the "fifo" case, right? When
>           i_sb->s_magic != PIPEFS_MAGIC...

I think we've done it for regular pipes too. You can see it with
'fstat()', after all.

And we've done it forever. It goes way back to even before the BK
days, although back when it was done differently with an open-coded

        inode->i_ctime = inode->i_mtime = CURRENT_TIME;
        mark_inode_dirty(inode);

instead.

I actually went back and looked at some historical trees. The inode
time updates were originally added in linux-2.0.1 (July 1996) and
didn't actually have the "mark_inode_dirty()" part, so they didn't
cause the inode to be written back to disk, but people would see the
time updates while they were happening.

The "write it back to disk" part started happening in 2.1.37pre1 (so
May 1997), although back then it was just a simple

        inode->i_dirt = 1;

instead.

My point being that we've been doing it for a *loong* time. And yes,
we've always done it for regular pipes too, not just on-disk FIFOs.

>         - why should we propogate the error code if "ret > 0" but
>           file_update_time() fails?

Normally file_update_time() wouldn't fail.

This was changed in c3b2da314834 ("fs: introduce inode operation
->update_time") and honestly, I think it was just a global
search-and-replace kind of change.

And I think the answer is: nobody cares, because it's FIFO's that
nobody uses in the first place, with an operation that never fails
anyway.

Could we remove the error propagation? Almost certainly. Does it
matter? Almost certainly not.

Notice how the read side also does the time update, except it's
obviously just atime, and it's done with

        if (ret > 0)
                file_accessed(filp);

instead (which honors O_NOATIME and then does touch_atime, and which
does the inode_update_time() *without* any error checking).

IOW, that is different, but it all boils down to the same thing:
nobody really cares in practice.

So to both of your issues, I think you can make changes as long as you
have good reasoning for them and document them in the commit (both
code and commit message).

           Linus


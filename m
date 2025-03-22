Return-Path: <linux-fsdevel+bounces-44773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D1A6C90E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33197A69B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7C1F9A86;
	Sat, 22 Mar 2025 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhI4Rd9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE91F8690;
	Sat, 22 Mar 2025 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638558; cv=none; b=kElQ5Ovw9zxHr7erIhGPuIg2snRLU0FtyDkEMqudlkKK/NuytZLnJpE+POrZrjvcvZkSztLNehUdTMrNBcRCa2ioeQPPsnmZqJadG7JW2OrukbdPvEuqn8lemUW7hCFsfiM07ngGWit42cAymC3UYUIOHcLYvEMBkp9RE75j2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638558; c=relaxed/simple;
	bh=okL0nmtEHDmW88SiF+aV+jWKQk7S2ItDum5kDyNXp80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkvRFYacax5xqOFCS8QxyVVjRXSk5bZCv2GIj2h8QGEpsqxDWijUUNbxwLwp00OycSgU2qFK+cHk2cGXyIEp/YKhgFIXZbh+baY+z9p7vPftAKvG0zVPLQSfCqoAOeuAzB1q44hOFjXZT64HpLYNk2cBo4ygWpxzdKcn3JeKqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhI4Rd9t; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso17954415e9.0;
        Sat, 22 Mar 2025 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742638555; x=1743243355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CqVkROA4dG75aQjTk+R2qOiPfKxllk/0j3YoZoCJgBI=;
        b=ZhI4Rd9tETz5BisXhusg0BzIXI6eFq5/NS0RDQyIFqQN7/TF/VyQIi/CF/QoptQM2H
         fwoN8xGL2idJuSRyHt74X7mTSm1b0l2SoGxokR38/BWb41MxpTW9USCHveMTKOqV/13m
         1Ty4V1w5/+J3GYoDDzQBLyj4uRJie99qCGTfsDf7H+cpac/omOMI1z5RQw01eyjMHH0d
         tIQqTlBm+cG2ePNSUJ0UjOOiz1pyASYvB2gOcyICx8FrO/tWJ0+nekaO96Lhde6xqxoa
         cnOztdf7WbmCKnwfaHNFEzilszfudV2/jYuPEtNq9eR9P7rwNaXGBOOwSe8lCtZWuups
         fr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742638555; x=1743243355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqVkROA4dG75aQjTk+R2qOiPfKxllk/0j3YoZoCJgBI=;
        b=gBo5BxX/OVow4Xkgs+deA0GHFCsdIzrxRIAK/XoDr+dhUagMm+BIN7D4YxVOihc2G+
         V9uvUzma3t5EkC34u5e5x2iSZx1UJl+WwX5TvGUkqiMTchN0dpwncA9v+CUM/XjAOVam
         9T5LMsdfJ+St9nXjFhMHJrNDcst+A+ZADbuPqiyEx4Fe62TulpMM567iFtiI2YAgRZRL
         L5BFfwVWLMK16h0Kph19MU9iV5e7yOaN61HyfVLUkyv50O6Fk8R+fn+G2XfKbLHVo9BG
         uqk6ofagOaKT38arkO+L38NXu6ltK6bupvx3LTA2Ycr4jgEn8AIZLmDcG0tb8ZM1QLgb
         V+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxWfSRHw3t6c4lsh73zbKg373Yjx0y1AFB4quLsePyX+nm+S2FcPDA2Py3VLBJ8MCctrZKk1guh8QdTUz3@vger.kernel.org, AJvYcCX+SOu58dzLL5RV+sTzVDKfTrSs/CdeRxQxEVWVF0GalrhwrsN5LOW7JMcRXXvkGMfDsVn1HuvxL+PyiEKg@vger.kernel.org
X-Gm-Message-State: AOJu0YwjdJec1oAKBleP/GV9l+/AC815gCBQrLGDzbzyfKfOeursT6I2
	ZTfyNi+QN4MFp512q0zssQeVfh5lnmj1yo5FqSxWfgbMqOaCEwfW
X-Gm-Gg: ASbGncvwJrYb3axuC0t+ZrM/AnbBVzPSk5aNJzX5AewajgOmtSG9DOOI96/lxO87SL9
	fpEllBOfJGNDXZlvJ4tm2yAPjZEM1Tt/5lxfoXvUcXKl/xHwr93wHvEVKNoMNCRPSBfC6GQx1RG
	jlgr+xpSluukiX59adWss4TDc/TNql2pDIKgxIKrd4js8x3uDnH+p4YMq06iu0W+Ol2V4nPn/3W
	swMDKL8y5Cg/GNlL5gJgTdJ67f9i0xHAJcZ8x+nJXL0kToMDZ25u6lNjqElsgIPIo55iGtVBq/O
	6Zwh0Uw4tnjFIDe5fmzzt+QZ9ibjESnsgrAj2SHlXLmDmxO3l2YXF3zEBcAB
X-Google-Smtp-Source: AGHT+IEIScTNuVLx6DrGfe/RJueop+NPQUZ6yI/awEzqGTgq5nw4AOwZc7P71l6R83PgdI8tK/lFGw==
X-Received: by 2002:a05:600c:3ca5:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-43d509edc2emr62650215e9.10.1742638554556;
        Sat, 22 Mar 2025 03:15:54 -0700 (PDT)
Received: from f (cst-prg-82-124.cust.vodafone.cz. [46.135.82.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9decbsm52659575e9.27.2025.03.22.03.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 03:15:53 -0700 (PDT)
Date: Sat, 22 Mar 2025 11:15:44 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <lhxexfurwfcr4fgwxmnhcqeii2qrzpoy7dflpwqio463x6jhrm@rttainje5vzq>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321-abdecken-infomaterial-2f373f8e3b3c@brauner>
 <20250322010008.GG2023217@ZenIV>
 <202503212313.1E55652@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202503212313.1E55652@keescook>

On Fri, Mar 21, 2025 at 11:26:03PM -0700, Kees Cook wrote:
> On Sat, Mar 22, 2025 at 01:00:08AM +0000, Al Viro wrote:
> > On Fri, Mar 21, 2025 at 09:45:39AM +0100, Christian Brauner wrote:
> > 
> > > Afaict, the only way this data race can happen is if we jump to the
> > > cleanup label and then reset current->fs->in_exec. If the execve was
> > > successful there's no one to race us with CLONE_FS obviously because we
> > > took down all other threads.
> > 
> > Not really.
> 
> Yeah, you found it. Thank you!
> 
> > 1) A enters check_unsafe_execve(), sets ->in_exec to 1
> > 2) B enters check_unsafe_execve(), sets ->in_exec to 1
> 
> With 3 threads A, B, and C already running, fs->users == 3, so steps (1)
> and (2) happily pass.
> 
> > 3) A calls exec_binprm(), fails (bad binary)
> > 4) A clears ->in_exec
> > 5) C calls clone(2) with CLONE_FS and spawns D - ->in_exec is 0
> 
> D's creation bumps fs->users == 4.
> 
> > 6) B gets through exec_binprm(), kills A and C, but not D.
> > 7) B clears ->in_exec, returns
> > 
> > Result: B and D share ->fs, B runs suid binary.
> > 
> > Had (5) happened prior to (2), (2) wouldn't have set ->in_exec;
> > had (5) happened prior to (4), clone() would've failed; had
> > (5) been delayed past (6), there wouldn't have been a thread
> > to call clone().
> > 
> > But in the window between (4) and (6), clone() doesn't see
> > execve() in progress and check_unsafe_execve() has already
> > been done, so it hadn't seen the extra thread.
> > 
> > IOW, it really is racy.  It's a counter, not a flag.
> 
> Yeah, I would agree. Totally untested patch:
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 506cd411f4ac..988b8621c079 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1632,7 +1632,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
>  	if (p->fs->users > n_fs)
>  		bprm->unsafe |= LSM_UNSAFE_SHARE;
>  	else
> -		p->fs->in_exec = 1;
> +		refcount_inc(&p->fs->in_exec);
>  	spin_unlock(&p->fs->lock);
>  }
>  
> @@ -1862,7 +1862,7 @@ static int bprm_execve(struct linux_binprm *bprm)
>  
>  	sched_mm_cid_after_execve(current);
>  	/* execve succeeded */
> -	current->fs->in_exec = 0;
> +	refcount_dec(&current->fs->in_exec);
>  	current->in_execve = 0;
>  	rseq_execve(current);
>  	user_events_execve(current);
> @@ -1881,7 +1881,7 @@ static int bprm_execve(struct linux_binprm *bprm)
>  		force_fatal_sig(SIGSEGV);
>  
>  	sched_mm_cid_after_execve(current);
> -	current->fs->in_exec = 0;
> +	refcount_dec(&current->fs->in_exec);
>  	current->in_execve = 0;
>  
>  	return retval;

The bump is conditional and with this patch you may be issuing
refcount_dec when you declined to refcount_inc.

A special case where there are others to worry about and which proceeds
with an exec without leaving in any indicators is imo sketchy.

I would argue it would make the most sense to serialize these execs.

Vast majority of programs are single-threaded when they exec with an
unshared ->fs, so they don't need to bear any overhead nor complexity
modulo a branch.

For any fucky case you can park yourself waiting for any pending exec to
finish.


Return-Path: <linux-fsdevel+bounces-8634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7310F839D81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 01:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25CDB230F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 00:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18DA64E;
	Wed, 24 Jan 2024 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eJmZ88BT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED311EA9
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054955; cv=none; b=kXUS51WSYVTUL5FixOvJ11tAel79ZzFSd+lNWz2HN9RKb9Y1r8daquXdmz5mHJHnoBIDCjuVsiBk/KBv+Ac+qjBjOTnm5BZx3UJptZZknvm27jXIKjt/MAM7IUZaoXqO/S7HgwMeN0cnZmSfZtWLksM6/Rm+Upilc/r/mindzRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054955; c=relaxed/simple;
	bh=JUZ8e8sDxBYjrwvOx1r1mk2i3gdTETSMbfB/THjmzhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bxs/+0Ls0qM2gj8vOacmJM8DgQRC6xTSWCC20nWBHSszMmBjcSRhpw7hETz2WOqqxdwqoG58BBBQ7FoZRJfgKg/dFT9h0CMSoWHcki2fqAQs+4sWjiVwBbZhvcsNBjO9hNwOo1tFDtQbzn0eYFS0/rVZkUTaMzjxC+7SHC+sHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eJmZ88BT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dd9f4c0809so14553b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 16:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706054953; x=1706659753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fi/zj5voHDPYKB6Z7ghbg+VPHgNO2bSCRicH9ZX7KmE=;
        b=eJmZ88BTtH/btdvJOfUcfeKA+WPdJIGPN4SvCnSXe941tLk7Hq58c76rGyjn5IgIQE
         C5EnI96TD6twb3v6PFGBvhBBaLC7lPA3bFd/9En9lv+3SmHi8GOg9B7iLbaroXfYKx+w
         QHrYC4slkfd4k3Hrzc0FaErgt2rc9wuZREfXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706054953; x=1706659753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi/zj5voHDPYKB6Z7ghbg+VPHgNO2bSCRicH9ZX7KmE=;
        b=e8rKHOhtjovNCmu04p1sFRWHn6DdMvIs6KAyeHg8Ct6wbiAGq9HZWU8tMFOSAYbxXz
         cJ3hVG7ZJFyynv1B9BMVVq8LbmJxKLfnzbDkiet7IZ99F1+pwGvrha4K+y+Zhe08IwtU
         G9wrWPeK+WX9JG9rbCgjoekynu3RlpEhCSC7e2hYwTUwxqt3vrnwDEnumz8Y7Bqsgqwf
         9xgieKiATCewIMMIxA1J1mbCBCLAATREsUDdeU0tJvV+giBlb4e1tWrlhI7mR7nXMtFD
         s3qP36eJWVFT/X10N7uWL0B+SyAjAiXOEHi6c5b3c/5TXi9bD9aJYnZTHl2atYVmLjht
         SoGA==
X-Gm-Message-State: AOJu0Yzi3/Ht40sUosZkp2VskBlUNfl6ChHN3RBtIa2VE/baTRnf53zA
	1zfDCTskpzlk02gvceMXVaB7YzM92i4sq6j4HUo+GyFsX3BStihyn+Wt+DbYDw==
X-Google-Smtp-Source: AGHT+IF/Rcc9ZWVa1OawRmGE1bBUza9XGJben23P16mFFKh9P3lRowBvA2V6yqh/hwNbfps8sMV1fg==
X-Received: by 2002:a05:6a00:138b:b0:6dd:8891:81ef with SMTP id t11-20020a056a00138b00b006dd889181efmr407925pfg.43.1706054953404;
        Tue, 23 Jan 2024 16:09:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r22-20020aa78456000000b006dd7f7b880bsm1841242pfn.133.2024.01.23.16.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:09:12 -0800 (PST)
Date: Tue, 23 Jan 2024 16:09:12 -0800
From: Kees Cook <keescook@chromium.org>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Adrian Reber <areber@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	tiozhang <tiozhang@didiglobal.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>,
	xu xin <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>
Subject: Re: [PATCH v14] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <202401231555.59B7EDBB2@keescook>
References: <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <20240116152210.GA12342@redhat.com>
 <AS8P193MB128538BC3833E654F56DA801E4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <20240117163739.GA32526@redhat.com>
 <AS8P193MB1285FDD902CC57C781AF2770E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <202401221328.5E7A82C32@keescook>
 <AS8P193MB1285110CC784C4BB30DAC0CAE4742@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285110CC784C4BB30DAC0CAE4742@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>

On Tue, Jan 23, 2024 at 07:30:52PM +0100, Bernd Edlinger wrote:
> - Currently a non-privileged program can potentially send such a privileged
> tracer into a deadlock.
> - With the alternative patch below that non-privileged can no longer send the
> tracer into a deadlock, but it can still quickly escape out of the tracer's
> control.
> - But with my latest patch a sufficiently privileged tracer can neither be
> sent into a deadlock nor can the attached process escape.  Mission completed.

Thanks for the details. And it would be pretty unfriendly to fail the execve()
too (or, rather, it makes the execve failure unpredictable). I'll keep
reading your patch...

-- 
Kees Cook


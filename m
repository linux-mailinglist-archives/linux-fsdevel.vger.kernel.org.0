Return-Path: <linux-fsdevel+bounces-9202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5FB83ECE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 12:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD80284393
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937062030A;
	Sat, 27 Jan 2024 11:23:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8DD51B;
	Sat, 27 Jan 2024 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706354635; cv=none; b=iE3wo/Pi/boCEji9dzahncDVeChVToEsEJcSBsdXNU3HX6eLWiXycJY81Rm/GbXMF6mwPTKNI8IuaSuejTg7yXjsvuVWea/Zm01z6GRDGRNKaBP6FnTSnKEjLk/ilSYhnCHpLQ21Gcp9n5XpCVi9yjOyY31bMhbt6diJ6VFxnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706354635; c=relaxed/simple;
	bh=jWtlu4f+xH/V+LUIjZawejjNpeQWHOqY77AUo8SxgZs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u2282gxOowLRW889BIMSYTp5NeNkuPdyADMnNlncD8xDmVMnPB6mSY9p7G0IU9SoKPDFPX2wAYCNT1FDEHM2kNptyzv7Zbm+vKgfT7XAZHZJ1VFC5hd3CcpQsdkx5NtNhR9a2xggoF8kVskk5ghIjQlqBnPLPk8J+qkNIcx8wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40RBN64w055077;
	Sat, 27 Jan 2024 20:23:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sat, 27 Jan 2024 20:23:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40RBN6FL055072
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Jan 2024 20:23:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f1ed6129-409a-484b-a7f4-71b2be90b60f@I-love.SAKURA.ne.jp>
Date: Sat, 27 Jan 2024 20:23:06 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
        Kevin Locke <kevin@kevinlocke.name>,
        Josh Triplett <josh@joshtriplett.org>,
        Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        John Johansen <john.johansen@canonical.com>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook>
 <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
 <a9210754-2f94-4075-872f-8f6a18f4af07@I-love.SAKURA.ne.jp>
 <CAHk-=wjF=zwZ88vRZe-AvexnmP1OCpKZSp_2aCfTpGeH1vLMkA@mail.gmail.com>
 <b5a12ecd-468d-4b50-9f8c-17ae2a2560b4@I-love.SAKURA.ne.jp>
 <0d820f39-2b9e-4294-801b-4fe30c71f497@I-love.SAKURA.ne.jp>
In-Reply-To: <0d820f39-2b9e-4294-801b-4fe30c71f497@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/27 20:00, Tetsuo Handa wrote:
> On 2024/01/27 16:04, Tetsuo Handa wrote:
>> If we can accept revival of security_bprm_free(), we can "get rid of current->in_execve flag"
>> and "stop saving things across two *independent* execve() calls".
> 
> Oops, I found a bug in TOMOYO (and possibly in AppArmor as well).
> TOMOYO has to continue depending on current->in_execve flag even if
> security_bprm_free() is revived.

No. We can "get rid of current->in_execve flag" and "stop saving things across
two *independent* execve() calls".

> @@ -327,9 +322,13 @@ static int tomoyo_file_fcntl(struct file *file, unsigned int cmd,
>   */
>  static int tomoyo_file_open(struct file *f)
>  {
> -       /* Don't check read permission here if called from execve(). */
> -       /* Illogically, FMODE_EXEC is in f_flags, not f_mode. */
> -       if (f->f_flags & __FMODE_EXEC)
> +       /*
> +        * Don't check read permission here if called from execve() for
> +        * the first time of that execve() request, for execute permission
> +        * will be checked at tomoyo_bprm_check_security() with argv/envp
> +        * taken into account.
> +        */
> +       if (current->in_execve && !tomoyo_task(current)->old_domain_info)

Since "f->f_flags & __FMODE_EXEC" == "current->in_execve", TOMOYO can continue using
"f->f_flags & __FMODE_EXEC", provided that tomoyo_task(current)->old_domain_info is
reset to NULL via security_bprm_free() callback when previous execve() request failed.

That is, if security_bprm_free() is revived, we can also get rid of current->in_execve.



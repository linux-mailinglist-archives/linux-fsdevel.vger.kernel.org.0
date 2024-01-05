Return-Path: <linux-fsdevel+bounces-7492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD3825C37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 22:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F861C23737
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD5123772;
	Fri,  5 Jan 2024 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DvAPBwUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCE224FB
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso5445a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704491152; x=1705095952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEXiwrq4KNUdt55Ouq+3g5whmUfNY0DSzzUMj+HSUwY=;
        b=DvAPBwUisQdTKVeb2QnpaAIkg5XvT/M8NI92tP3BRcKWJnZe2lomkZMjBNZdmsW/TR
         ZrZt9xyIm11BqgRKNmdjYP8//P/wcj+g+cJqickXg7KgpxVVQK//8TEwLKMK/PFjNlQM
         aqqDjweJG5Tun+umhcQ99S15jh5xXtsjCYLfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704491152; x=1705095952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEXiwrq4KNUdt55Ouq+3g5whmUfNY0DSzzUMj+HSUwY=;
        b=HfkYOGgTCVj5Hi/JHvCZF4rGlP6b6PvHueAWR3Jw0vwjIYsLWLsFeguWd5SoNdbrAs
         wC8ibX0WfNnvsp/1eg5LE7mvgJhUWU9ThiKkmj+4REmSr7cStuayhuZLtymS1VoX1PVJ
         Ok30ihEDm5doIDVVDS4yHIMSIkZhs3wfUO83Un8zr4ky6pR5LfxPNHBO+ns+Z2MDa4y5
         kYkaDzKULm27R5NeaozYQ96umZB1tq7xG3Ju/eyrH5xdE38DhQ5EKKa3FfWntXIJRPVn
         ZsnITjEeRVa6RIcMg4pAQdgnXVB5zJbwCpSKxqTSYTPckHgMKZKNPFm8cXkvTg10+yZH
         61VA==
X-Gm-Message-State: AOJu0YzUZ7hnMV//R9Pu4+JeiIYEAhVP0P2cci6zgfApzGbs1PmWwG8G
	Y8fAAMTM24bF6kzmLRvzEdHpq7QFxJIsQCWHQ8nr64UEXE5jGhxz
X-Google-Smtp-Source: AGHT+IFx76E6g2zWX4sJtqaRNte9nQOlYKAf8a/o/p1xZ21CAkqDm0UpSPfzspRzfzq1CmKJHDENZA==
X-Received: by 2002:a50:cdc9:0:b0:557:392f:82de with SMTP id h9-20020a50cdc9000000b00557392f82demr23832edj.15.1704491152515;
        Fri, 05 Jan 2024 13:45:52 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id es12-20020a056402380c00b005530cb1464bsm1362261edb.15.2024.01.05.13.45.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 13:45:51 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so133725e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 13:45:51 -0800 (PST)
X-Received: by 2002:a7b:c34d:0:b0:40d:4de8:222c with SMTP id
 l13-20020a7bc34d000000b0040d4de8222cmr35659wmj.252.1704491151463; Fri, 05 Jan
 2024 13:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-4-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 13:45:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
Message-ID: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Ok, I've gone through the whole series now, and I don't find anything
objectionable.

Which may only mean that I didn't notice something, of course, but at
least there's nothing I'd consider obvious.

I keep coming back to this 03/29 patch, because it's kind of the heart
of it, and I have one more small nit, but it's also purely stylistic:

On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> +bool bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +       /* BPF token allows ns_capable() level of capabilities, but only if
> +        * token's userns is *exactly* the same as current user's userns
> +        */
> +       if (token && current_user_ns() == token->userns) {
> +               if (ns_capable(token->userns, cap))
> +                       return true;
> +               if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
> +                       return true;
> +       }
> +       /* otherwise fallback to capable() checks */
> +       return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> +}

This *feels* like it should be written as

    bool bpf_token_capable(const struct bpf_token *token, int cap)
    {
        struct user_namespace *ns = &init_ns;

        /* BPF token allows ns_capable() level of capabilities, but only if
         * token's userns is *exactly* the same as current user's userns
         */
        if (token && current_user_ns() == token->userns)
                ns = token->userns;
        return ns_capable(ns, cap) ||
                (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
    }

And yes, I realize that the function will end up later growing a

        security_bpf_token_capable(token, cap)

test inside that 'if (token ..)' statement, and this would change the
order of that test so that the LSM hook would now be done before the
capability checks are done, but that all still seems just more of an
argument for the simplification.

So the end result would be something like

    bool bpf_token_capable(const struct bpf_token *token, int cap)
    {
        struct user_namespace *ns = &init_ns;

        if (token && current_user_ns() == token->userns) {
                if (security_bpf_token_capable(token, cap) < 0)
                        return false;
                ns = token->userns;
        }
        return ns_capable(ns, cap) ||
                (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
    }

although I feel that with that LSM hook, maybe this all should return
the error code (zero or negative), not a bool for success?

Also, should "current_user_ns() != token->userns" perhaps be an error
condition, rather than a "fall back to init_ns" condition?

Again, none of this is a big deal. I do think you're dropping the LSM
error code on the floor, and are duplicating the "ns_capable()" vs
"capable()" logic as-is, but none of this is a deal breaker, just more
of my commentary on the patch and about the logic here.

And yeah, I don't exactly love how you say "ok, if there's a token and
it doesn't match, I'll not use it" rather than "if the token namespace
doesn't match, it's an error", but maybe there's some usability issue
here?

              Linus


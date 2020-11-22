Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFF42BC5E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 14:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgKVNwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 08:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgKVNw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 08:52:29 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84789C0613CF;
        Sun, 22 Nov 2020 05:52:29 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z21so20054365lfe.12;
        Sun, 22 Nov 2020 05:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8NZTCaCqQv7102djPN8aAR+U45rXDmP7ZYo82fEQo0s=;
        b=e25shkJKBug0QP9Z7CJGmECGB1fs8KNolJ+ZVAZJ0BjSfH1Vcv9AF6bBRPG38G65V0
         125CoIa6gAndVU70px0cyeBA22Ly0hUb2EU0fzT6Pwh0fOqK2esRGecbKOJzpX7A5na0
         Nsa+W6w0EnCKqUfYwdiHHfGT22Zouv9HsgvrIhioloPTOGvLv/+2N+npXlD8RDgOGsle
         7RNK21pREjx9yPWce6BVA5WBSNAzD3fzJlUd7xteJamTt/No8t1+obWoeq7rc8a70eOt
         ApjVLv2HtArmSP9JJzfS5Vr28mVk7qt961wEKagz33InJT5GPG0hjzZgwNOcEigsIXJ5
         q5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8NZTCaCqQv7102djPN8aAR+U45rXDmP7ZYo82fEQo0s=;
        b=mWgk+voQcAG5pkHy0I4envHrI4gghzMGVVNhz6FysHcqHIrgpVQDz8uBZHI1J4YzAu
         sCmZkeXaDM9tT1fCcSRinUftcK46RKpbyDodEQnuwCOxLT8Dwm0HuhUzynsbyY/5Ie83
         aPV9XDGpHzdfOO8eoJviBLeIws1NoHmB3puYmyGzvFwUj5s0EuhzIxYbTqF+SMZOMz1C
         GSnXtk8ip4MNAth9toeJ2UD6dsf3ssBOd0rHAvpSM9+DxjGytRnuX1tsrSLTIRyD7yYf
         2mP4RX1rproODagzWKI9mvZewLT8sZP/oggitvXo37w0SThR6caSWIvbcWDVNmYhk3VL
         Q1+w==
X-Gm-Message-State: AOAM530i4xuyKns9gTHYP9i9FsbSERGmvZHaT0Jeym3inDjGqIo4Q5gg
        Y8w2C3/BtndxVzzyzBeSxtk=
X-Google-Smtp-Source: ABdhPJyjKEKc3MBfIEFh5den4bOpwrKPaQDT6wncc9l3FBfbIMKe2ZL5goqhfPnXCHYxzf8wJUqLfQ==
X-Received: by 2002:a19:cbc6:: with SMTP id b189mr11659879lfg.275.1606053147989;
        Sun, 22 Nov 2020 05:52:27 -0800 (PST)
Received: from grain.localdomain ([5.18.91.94])
        by smtp.gmail.com with ESMTPSA id j69sm1045550lfj.49.2020.11.22.05.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 05:52:26 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id D34D61A008D; Sun, 22 Nov 2020 16:52:25 +0300 (MSK)
Date:   Sun, 22 Nov 2020 16:52:25 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>,
        Kees Cook <keescook@chromium.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH v2 11/24] file: Implement task_lookup_fd_rcu
Message-ID: <20201122135225.GI875895@grain>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-11-ebiederm@xmission.com>
 <20201121181933.GH875895@grain>
 <87blfp1r8b.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blfp1r8b.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 22, 2020 at 07:00:20AM -0600, Eric W. Biederman wrote:
> Cyrill Gorcunov <gorcunov@gmail.com> writes:
...
> That is present in files_lookup_fd_rcu, so this code should
> be good from the warning side.

Indeed, thanks!

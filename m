Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5819BCE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbgDBHkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 03:40:53 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37792 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgDBHkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:40:53 -0400
Received: by mail-pj1-f66.google.com with SMTP id k3so1187371pjj.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rRniYv7RPwWHFWrPJUZ8iMNVA0tUTHJrCguWpqpN+6k=;
        b=ZgYWh0h+a5Hg2gYuDaf7bAJw/KFnrjKUiEuvbptyyu8Ds6OObwEJ9RIl0P+Ognz7ON
         aVcJvZkmoY5pTE9Oigwg6Rz73WgiRqYNakHvrmSrDodIpjaHrTg1KZr/8/65eN0WM5/I
         HNXT2GWnBGZf3TIUSbj5+3eAx6Fzc29HW0q/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rRniYv7RPwWHFWrPJUZ8iMNVA0tUTHJrCguWpqpN+6k=;
        b=CnQ2K0W6x78aVPJy73fZ0v7gF2v3jrz+ki0AbA7pYETciTndvgOmCaLPZMfORHEfAk
         rCEtpP7kcVAc7gPtJv9DcJoh9/o5TEBaW12ZyHp+8B5M/lVtyWqQ2uunAh5a4mwCFQ/G
         DlPPsz5J62s7qs/X7J30KMQUOY310ngXklh9rJWUGrYTW17OnJJcCeR77zjqufAfOkVx
         /g/0A/RPT8f5YIUFadPEaGUazhW0Df+WjP9nIKzogxQdGJulNHRr2xVZRA+QqCqubgv/
         KCxaVRXqfDqUOpNw3XlVPui9tUjWNNd7IUQYbMFRMoo8S8BKOGO2vK75G2nDkEM7JECr
         uF4w==
X-Gm-Message-State: AGi0PuZxvhnP4mobEyuztZqD/6wIOle6f5aqu52ze9hxYgopvVYeTphG
        9Uy1ZdYbD+OxceEkvsUPDDjMjQ==
X-Google-Smtp-Source: APiQypI2cYt4enOL7sTbasi+WDYQtLGOhHbbnJYUSxIit5amZbHaBwsNKTd/VramUXhMpxHV80lNww==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr1769890plq.79.1585813251785;
        Thu, 02 Apr 2020 00:40:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 8sm3137514pfy.130.2020.04.02.00.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:40:50 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:40:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v6 00/16] Infrastructure to allow fixing exec deadlocks
Message-ID: <202004020037.67ED66C8B6@keescook>
References: <AM6PR03MB5170B2F5BE24A28980D05780E4F50@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <871rpg8o7v.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170938306F22C3CF61CC573E4CD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <202003282041.A2639091@keescook>
 <AM6PR03MB5170E0E722ED0B05B149C135E4CB0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <20200330201459.GF22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330201459.GF22483@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 01:14:59PM -0700, Matthew Wilcox wrote:
> On Mon, Mar 30, 2020 at 10:12:02PM +0200, Bernd Edlinger wrote:
> > On 3/29/20 5:44 AM, Kees Cook wrote:
> > > On Sat, Mar 28, 2020 at 11:32:35PM +0100, Bernd Edlinger wrote:
> > >> Oh, do I understand you right, that I can add a From: in the
> > >> *body* of the mail, and then the From: in the MIME header part
> > >> which I cannot change is ignored, so I can make you the author?
> > > 
> > > Correct. (If you use "git send-email" it'll do this automatically.)
> > > 
> > > e.g., trimmed from my workflow:
> > > 
> > > git format-patch -n --to "$to" --cover-letter -o outgoing/ \
> > > 	--subject-prefix "PATCH v$version" "$SHA"
> > > edit outgoing/0000-*
> > > git send-email --transfer-encoding=8bit --8bit-encoding=UTF-8 \
> > > 	--from="$ME" --to="$to" --cc="$ME" --cc="...more..." outgoing/*
> > > 
> > > 
> > 
> > Okay, thanks, I see that is very helpful information for me, and in
> > this case I had also fixed a small bug in one of Eric's patches, which
> > was initially overlooked (aquiring mutexes in wrong order,
> > releasing an unlocked mutex in some error paths).
> > I am completely unexperienced, and something that complex was not
> > expected to happen :-) so this is just to make sure I can handle it
> > correctly if something like this happens again.
> > 
> > In the case of PATCH v6 05/16 I removed the Reviewd-by: Bernd Edlinger
> > since it is now somehow two authors and reviewing own code is obviously
> > not ok, instead I added a Signed-off-by: Bernd Edlinger (and posted the
> > whole series on Eric's behalf (after asking Eric's permissing per off-list
> > e-mail, which probably ended in his spam folder)
> > 
> > Is this having two Signed-off-by: for mutliple authors the
> > correct way to handle a shared authorship?
> 
> If the patch comes through you, then Reviewed-by: is inappropriate.
> Instead, you should use Signed-off-by: in the second sense of
> Documentation/process/submitting-patches.rst
> 
> This also documents how to handle "minor changes" that you make.

And in the true case of multiple authors, have both SoBs, but also add a
Co-developed-by: for the non-"git author" author. Specific details:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

-- 
Kees Cook

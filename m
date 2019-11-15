Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2FAFE54A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 19:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKOSwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 13:52:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43168 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:52:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id y23so11732883ljh.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2019 10:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4xtaCr8bksk7hZhv5KKTwu+2iaD2qyURktvDZXazkc=;
        b=egY2spLHGrR8gGG3xgZthsV14T8zMUbAEU8nKs0WE79SJJeYlT6diMl1apCO7hfIfO
         tSqtul8DRPTMZKBrjOt/ltN4StE8fYapzmVL9CihIAD7zosIaWJTZpUQeSumxCyfstuN
         J7W82IwYXTpcy8GJO0MisBQrqCmUiCr69scXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4xtaCr8bksk7hZhv5KKTwu+2iaD2qyURktvDZXazkc=;
        b=aJG4jdSfP7MN0/WeXb9l+QOgLREycvQizw4ZHBni3I1XxmGnFTLXMFlBMBNKJDsrg/
         eORxsBYuh8rw9/v9ijr6z2GJawd6w8gFfzLMc2n+qOH105LcHaS4XwFAhK+bjoTl6ohD
         siuVy6ze1o/24bzfE68cHF0/PUfC12n5iBm25EUHRHSijpQ5iBmrPV+1ozmX01lklo1g
         c/r8wR+IF1aVxiGXhOmorV2UyBwrVU10O+1mdDmhidBb+aMl5t/7fBINIq1BDD/JTFZ6
         bnKg6Gb03efCtFvIQvp11jQEAnblb0up9ZzqWDJL1yoWppAFkKw7I8/xb4a4f2TLr0Tn
         Xyqw==
X-Gm-Message-State: APjAAAVf9Gtg8jDyjOL8LMCGnBFQLGJuwLtiRWIlDbNSGwjJ7z0j6NwY
        Y/OlqR9LHe5lzSh3k5K+Di3/Lhi/hz4=
X-Google-Smtp-Source: APXvYqy+Db6Cgm7uJhXLU6Dhcs/Onvqni/RaOc9KWQr+RtxDqTCcapyx6G672t05KJd0q+fGJZKmjw==
X-Received: by 2002:a2e:8855:: with SMTP id z21mr12869991ljj.212.1573843932688;
        Fri, 15 Nov 2019 10:52:12 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q124sm4333232ljq.93.2019.11.15.10.52.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 10:52:11 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 139so11780069ljf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2019 10:52:11 -0800 (PST)
X-Received: by 2002:a2e:9a8f:: with SMTP id p15mr12453823lji.148.1573843931177;
 Fri, 15 Nov 2019 10:52:11 -0800 (PST)
MIME-Version: 1.0
References: <157375686331.16781.5317786612607603165.stgit@warthog.procyon.org.uk>
In-Reply-To: <157375686331.16781.5317786612607603165.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Nov 2019 10:51:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJMHz=vsvMLGb8q3ECk5odJkO5Sp438+rs6r30FUbP0A@mail.gmail.com>
Message-ID: <CAHk-=wgJMHz=vsvMLGb8q3ECk5odJkO5Sp438+rs6r30FUbP0A@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix race in commit bulk status fetch
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:41 AM David Howells <dhowells@redhat.com> wrote:
>
> Fix this by skipping the update if the inode is being created as the
> creator will presumably set up the inode with the same information.

Applied,

          Linus

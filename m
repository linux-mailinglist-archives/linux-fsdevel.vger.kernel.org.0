Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D622F9D54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 23:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKLWor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 17:44:47 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:43539 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfKLWor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:44:47 -0500
Received: by mail-pf1-f177.google.com with SMTP id 3so116740pfb.10;
        Tue, 12 Nov 2019 14:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YP6HXQfqzmkkZWDyrOvnEJK7kISWvdIhSDIzf9Us7t8=;
        b=OcrokoyIrP6/2K/P/cPaAzNyafqPVWJGbTOeNMu4v5ASYwpfwhvhkehljA61C9f6GY
         XyNZ2lffsKCNHYu9LGAJCsSyg/Y/v8fyiKntIqItHyY9sVZLZKhGFTk+beOxYshM7iEm
         kmA76t5UG4F43tVYAYE6rljD5L+S1BGpml/gQ51PrjrrAVUgyaQ5SQGjlixMnrfrywKz
         Qa5Z1XIA2tqQGH2i6fYipScsVBYBMY/75ILLWSX0ggD5jDCN8h1tiYEHZ5O/7a2C3Ag+
         Y+zjruCVPl1sNPcPKmestiVm9vRZOCaV7TJ4Pd9M9jtVWz2I211E0c3vps5vwy/4ewhL
         ZDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YP6HXQfqzmkkZWDyrOvnEJK7kISWvdIhSDIzf9Us7t8=;
        b=kaeE+CcI7yDQ/BjLslpUpzCTWsJH7WExfVaAx4WEUHE2B+TuyZEcmDueR+jpbuIX9W
         WwO0kgchqdA2DW6BHvFMNpaRvnvFWRoTvi3zQYEToRFRC/9yCTjhz3ZrmP2rFfzu3QR3
         YXOXKyPAQ43hP6laN9tlsg5oOUNDFDGQremkYG6x6Hq2uB/ge9k+41D9qng8kJ9+AvyU
         +uy7ygPSmZIoXmuW8BfW92PEslX2orYIfzGoZT0G4UKZCXrZLlpFn/iEFQ7Dz973uDBz
         J9FHgQ/S8TpkGBhzO04zydrTkcfhzy4+h4CGO3wWLG1EcfqVUdoE4fex7YZ8ZXIS7kRG
         I4ag==
X-Gm-Message-State: APjAAAUoUaNrBFV6pxXIzhVfa+V5nQlhruO3ms7x7YxzjCvcTV1XXl91
        7frgGXwYiDYyGw//Pr6Th/8LLzti
X-Google-Smtp-Source: APXvYqweYCXNIbkVwq3Q28iNQJZLxJJhGWqlAFjHUjBOAF460Nj3e6jQLicpl8NTi7QmbU6q49jY2g==
X-Received: by 2002:a63:d851:: with SMTP id k17mr7856562pgj.161.1573598685627;
        Tue, 12 Nov 2019 14:44:45 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:e001])
        by smtp.gmail.com with ESMTPSA id i32sm20900pgl.73.2019.11.12.14.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 14:44:44 -0800 (PST)
Date:   Tue, 12 Nov 2019 14:44:43 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
Message-ID: <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com>
References: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
 <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 02:07:03PM -0800, Eric Dumazet wrote:
> 
> I would prefer some kind of explicit marking, instead of a comment.
> 
> Even if we prefer having a sane compiler, having these clearly
> annotated can help
> code readability quite a lot.

Annotating every line where tsk->min_flt is used with a comment
or explicit macro seems like a lot of churn.
How about adding an attribute to a field ?
Or an attribute to a type?

clang attributes can be easily exteneded. We add bpf specific attributes
that are known to clang only when 'clang -target bpf' is used.
There could be x86 or generic attributes.
Then one can do:
typedef unsigned long __attribute__((ignore_data_race)) racy_u64;
struct task_struct { 
   racy_u64 min_flt;
};

Hopefully less churn and clear signal to clang.


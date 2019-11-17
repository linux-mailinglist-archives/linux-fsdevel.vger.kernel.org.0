Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86799FFB72
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2019 20:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfKQTLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 14:11:32 -0500
Received: from mail134-9.atl141.mandrillapp.com ([198.2.134.9]:54201 "EHLO
        mail134-9.atl141.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfKQTLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 14:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=IhQsKuWDqlUOni5MXX37x6JtBfi/hPnDeOj2BecfOLM=;
 b=ThMlz/6pPoicY1BMPBixOTbpzA3pxU7qhEhv4eU55RWUUTfrgDgXr3vBxJCFm0VIUyOQXWDGczte
   PD0rpOey/CquuPjiiB84+hzCcdt7atiRJuy6ZC4JL68vtodzdyzuP431plAVaF8ImNMf9Sa/PFNL
   rff0lg5kOC8hacWSdLU=
Received: from pmta03.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail134-9.atl141.mandrillapp.com id hq6dm41sau8j for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2019 18:56:29 +0000 (envelope-from <bounce-md_31050260.5dd197dd.v1-808923d0389446aba63250589de843e6@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1574016989; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=IhQsKuWDqlUOni5MXX37x6JtBfi/hPnDeOj2BecfOLM=; 
 b=G1fJeWjpDXsJBgFY/aEMfUq7QKaLs4YPUZ6cbITNIxAB686gDzPfPUKl30gNYpl0ymQQr6
 u4o7WpdSkjk54Gyc3kideis7KUcYmEMvd/KhsSifXPoTxjP1kw71A0DVnFdVca8k42Mvop7k
 A0HZWn8uGhbGDyYM3+yAAEKu+Xjbg=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
Received: from [87.98.221.171] by mandrillapp.com id 808923d0389446aba63250589de843e6; Sun, 17 Nov 2019 18:56:29 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Message-Id: <20191117185623.GA22280@deco.navytux.spb.ru>
References: <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com> <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com> <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com> <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com> <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com> <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com> <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com> <20191112165033.GA7905@deco.navytux.spb.ru> <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com> <CAHk-=whPFjpOEfU5N4qz_gGC8_=NLh1VkBLm09K1S1Gcma5pzA@mail.gmail.com>
In-Reply-To: <CAHk-=whPFjpOEfU5N4qz_gGC8_=NLh1VkBLm09K1S1Gcma5pzA@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.808923d0389446aba63250589de843e6
X-Mandrill-User: md_31050260
Date:   Sun, 17 Nov 2019 18:56:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 09:36:41AM -0800, Linus Torvalds wrote:
> On Tue, Nov 12, 2019 at 9:23 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. I thought we already then applied all the patches that marked
> > things that didn't use f_pos as FMODE_STREAM. Including pipes and
> > sockets etc.
> >
> > But if we didn't - and no, I didn't double-check now either - then
> > obviously that part of the patch can't be applied now.
> 
> Ok, looking at it now.
> 
> Yeah, commit c5bf68fe0c86 ("*: convert stream-like files from
> nonseekable_open -> stream_open") did the scripted thing, but it only
> did it for nonseekable_open, not for the more complicated cases.
> 
> So yup, you're right - we'd need to at least do the pipe/socket case too.
> 
> What happens if the actual conversion part (nonseekable_open ->
> stream_open) is removed from the cocci script, and it's used to only
> find "read/write doesn't use f_pos" cases?
> 
> Or maybe trigger on '.llseek = no_llseek'?

( just a quick update that I'm still pending on this. I've tried to
  quickly check the above this evening but offhand it does not give good
  results until stream_open.cocci is extended to understand
  read_iter/writer_iter and properly worked some more on it.
  Or maybe I'm just too sleepy...

  I'd like to take a time break for now.
  I will try to return to this topic after finishing my main work first.
  I apologize for the inconvenience. )

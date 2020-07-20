Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2793226C18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgGTQq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:46:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56794 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgGTPkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:40:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KFWLrA178324;
        Mon, 20 Jul 2020 15:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=6RfasIF7cxCPDg7wAmtE0BcBdqimXQnrKGeRqhnInMc=;
 b=cD3UhEWtyE1tK6OE5XEZAGN8y9zOQ/LscUMaZTL7+tw5ppCIeL6PSLLdfe1EAp3yGuKo
 QtOaQpfwTIzaw/DveEUHOlQoTDgG7Wt/tnrY8yKYEUtwtS5jwW/RehCRUODOh25bDwVa
 7lG7pN/reZNn3niGZU4a5+sjAlkDEgW6nZ4jQerMnKJaX/A+glaKmN9MRhS7u+F4vXoE
 jK0cCQscjpaJdHNqyyYOPDSJ08mJIcKv970tbshJzz/hyIkqZTZSgxkeifsunmWE5Mkx
 eyBIElvZihv/iC6wvlBA9rRVK4Binpo52hcE11e+gtNMBIFRvuZxtYigEDGAzr8c6JwS bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 32bpkayy3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 15:39:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KFYBWP171021;
        Mon, 20 Jul 2020 15:37:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 32d8m098u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 15:37:45 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06KFbXMZ020844;
        Mon, 20 Jul 2020 15:37:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 08:37:33 -0700
Date:   Mon, 20 Jul 2020 08:37:31 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200720153731.GB7597@magnolia>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
 <20200718140811.GA1179836@rowland.harvard.edu>
 <20200720013320.GP5369@dread.disaster.area>
 <20200720145211.GC1228057@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200720145211.GC1228057@rowland.harvard.edu>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=1 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200106
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:52:11AM -0400, Alan Stern wrote:
> On Mon, Jul 20, 2020 at 11:33:20AM +1000, Dave Chinner wrote:
> > On Sat, Jul 18, 2020 at 10:08:11AM -0400, Alan Stern wrote:
> > > > This is one of the reasons that the LKMM documetnation is so damn
> > > > difficult to read and understand: just understanding the vocabulary
> > > > it uses requires a huge learning curve, and it's not defined
> > > > anywhere. Understanding the syntax of examples requires a huge
> > > > learning curve, because it's not defined anywhere. 
> > > 
> > > Have you seen tools/memory-model/Documentation/explanation.txt?
> > 
> > <raises eyebrow>
> > 
> > Well, yes. Several times. I look at it almost daily, but that
> > doesn't mean it's approachable, easy to read or even -that I
> > understand what large parts of it say-. IOWs, that's one of the 
> > problematic documents that I've been saying have a huge learning
> > curve.
> 
> Can you be more specific?  For example, exactly where does it start to 
> become unapproachable or difficult to read?
> 
> Don't forget that this document was meant to help mitigate the LKMM's 
> learning curve.  If it isn't successful, I want to improve it.
> 
> > So, if I say "the LKMM documentation", I mean -all- of the
> > documentation, not just some tiny subset of it. I've read it all,
> > I've even installed herd7 so I can run the litmus tests to see if
> > that helps me understand the documentation better.
> > 
> > That only increased the WTF factor because the documentation of that
> > stuff is far, far more impenetrable than the LKMM documentation.  If
> > the LKMM learnign curve is near vertical, then the stuff in the
> > herd7 tools is an -overhang-. And I most certainly can't climb
> > that....
> 
> I can't argue with that.  Really understanding herd7 does require a 
> pretty extensive background in the field.
> 
> > /me idly wonders if you recognise that your comment is, yet again, a
> > classic demonstration of the behaviour the "curse of knowledge"
> > cognitive bias describes.
> 
> Not at all.  I think you are confusing several different things.
> 
> For one, at a purely literal level my comment could not possibly be 
> taken as a demonstration of "curse of knowledge" behavior, because it 
> was a simple question: Have you seen explanation.txt?  Nothing obscure 
> or outré about that.
> 
> For another, you appear to be confusing the LKMM with the kernel's API, 
> and reference documents with programming guides (or recipes).  I'm sure 
> that you aren't doing this deliberately and are well aware of these 
> distinctions, but that's the impression your email leaves.
> 
> > > That
> > > file was specifically written for non-experts to help them overcome the
> > > learning curve.  It tries to define the vocabulary as terms are
> > > introduced and to avoid using obscure syntax.
> > 
> > It tries to teach people about what a memory model is at the same
> > time it tries to define the LKMM. What it doesn't do at all is
> > teach people how to write safe code.
> 
> Of course it doesn't.  It was never meant to.  You can see this right in 
> the filename "explanation.txt"; its purpose is to explain the LKMM.  
> Nobody ever claimed it teaches how to write safe code or how to use the 
> kernel's concurrent-programming API.  Those things belong in a separate 
> document, such as recipes.txt.
> 
> >  People want to write safe code,
> > not become "memory model experts".
> 
> Speak for yourself.  I personally want both, and no doubt there are 
> others who feel the same way.

Ok then.  I'm a lazy a***** maintainer who wants to write safe code
without first having to understand the memory models of *multiple CPU
architectures*, and I'm perfectly fine with accepting the smallest
common featureset across those CPUs so that I can think as little as
possible about things outside my area of expertise.

Willy's proposed API looks good enough for me, and if that's all I ever
have to know, I'm good with that.  Eric's proposed recipes patch is a
decent breadcrumb should I ever desire to know more.  I don't expect
I'll read the LKMM, just like I don't expect any of the rest of you will
read the XFS internals book.

(Well, ok, I imagine Dave has...)

--D

> 
> > Memory models are -your expertise- but they aren't mine. My
> > expertise is filesystems: I don't care about the nitty gritty
> > details of memory models, I just want to be able to write lockless
> > algorithms correctly. Which, I might point out, I've been doing for
> > well over a decade...
> 
> That's perfectly fine; I understand completely.  But your criticism is 
> misplaced: It should be applied to recipes.txt, not to explanation.txt.
> 
> And remember: It was _you_ who claimed: "just understanding the 
> vocabulary [the LKMM] uses requires a huge learning curve, and it's not 
> defined anywhere".  explanation.txt shows that this statement is at 
> least partly wrong.  Besides, given that you don't care about the nitty 
> gritty details of memory models in any case, why are you complaining 
> that understanding the LKMM is so hard?
> 
> My impression is that you really want to complain about the inadequate 
> quality of recipes.txt as a programmers' guide.  Fine, but don't extend 
> that to a blanket condemnation of all the LKMM documentation.
> 
> > > If you think it needs improvement and can give some specific
> > > details about where it falls short, I would like to hear them.
> > 
> > Haven't you understood anything I've been saying? That developers
> > don't care about how the theory behind the memory model  or how it
> > works - we just want to be able to write safe code.
> 
> Again, speak for yourself.
> 
> >  And to do that
> > quickly and efficiently. The "make the documentation more complex"
> > response is the wrong direction. Please *dumb it down* to the most
> > basic, simplest, common concurrency patterns that programmers use
> > and then write APIs to do those things that *hide the memory model
> > for the programmer*.
> > 
> > Adding documentation about all the possible things you could do,
> > all the optimisations you could make, all the intricate, subtle
> > variations you can use, etc is not helpful. It might be interesting
> > to you, but I just want -somethign that works- and not have to
> > understand the LKMM to get stuff done.
> 
> In principle, both can be included in the same document.  Say, with the 
> more in-depth discussions relegated to specially marked-off sections 
> that readers are invited to skip if they aren't interested.
> 
> > Example: I know how smp_load_acquire() works. I know that I can
> > expect the same behavioural semantics from smp_cond_load_acquire().
> > But I don't care how the implementation of smp_cond_load_acquire()
> > is optimised to minimise ordering barriers as it spins. That sort of
> > optimisation is your job, not mine - I just want a function that
> > will spin safely until a specific value is seen and then return with
> > acquire semantics on the successful load.....
> > 
> > Can you see the difference between "understanding the LKMM
> > documenation" vs "using a well defined API that provides commonly
> > used functionality" to write correct, optimal code that needs to
> > spin waiting for some other context to update a variable?
> 
> Certainly I can.  Can't _you_ see the difference between a document that 
> helps people "understand the LKMM" and one that demonstrates "using a 
> well defined API that provides commonly used functionality"?
> 
> > That's the problem the LKMM documentation fails to address. It is
> > written to explain the theory behind the LKMM rather than provide
> > developers with pointers to the templates and APIs that implement
> > the lockless co-ordination functionality they want to use....
> 
> That's the difference between a reference document and a programmers' 
> guide.  Grousing that one isn't the other is futile.
> 
> On the other hand, pointing out specific areas of improvement for a 
> document that was meant to be a programmers' guide can be very helpful. 
> You may not be inclined to spend any time editing recipes.txt, but 
> perhaps you could point out a few of the specific areas most in need of 
> work?
> 
> Alan Stern

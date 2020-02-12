Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6682515A178
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 07:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgBLG6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 01:58:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33592 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgBLG6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:58:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C6wRNH066873;
        Wed, 12 Feb 2020 06:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Sr20t6Xix01NZSffARVrwrh9AtL2X5oyFM2Mcr1ZOHE=;
 b=cJQPjXx6NYjKn3RGwxLh+zMhkjJfwlM1gS6wtkyyAa/Q6p+t81AtwoRDvlIet2UUmDvk
 01pON0OmeueVJUGFt7BnKCynhlbTSMrRanC7A2MPsYYn5dxP4b8o8Q2oRoRs1g4BjvW9
 jhQKlFiBHvAKqf7MlOli60imd6LP5OENHi5DKaIknh60DuMyjM7VLudFTSVUlVwvpPAS
 VQHfEAv8Eeqgr6VkGfxwBUtSCJBb5nRtZhGH4JueQi1KTeukTytHFvWFHoKeu59iYtDC
 7mZj6i7KQFgnMHEHIeInxdGXKNYPb9CiyApw+eDtGrHs2vvPWS7catzdNFUAhCywWt1+ fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y2k888aje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 06:58:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C6uUdF009757;
        Wed, 12 Feb 2020 06:58:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y26sva4g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 06:58:26 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01C6wOPD014397;
        Wed, 12 Feb 2020 06:58:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Feb 2020 22:58:24 -0800
Date:   Tue, 11 Feb 2020 22:58:23 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Allison Collins <allison.henderson@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200212065823.GI6874@magnolia>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
 <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
 <87sgjg7j0t.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgjg7j0t.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120055
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:21:06AM +1100, NeilBrown wrote:
> On Sun, Feb 09 2020, Allison Collins wrote:
> 
> > Well, I can see the response is meant to be encouraging, and you are 
> > right that everyone needs to give to receive :-)
> >
> > I have thought a lot about this, and I do have some opinions about it 
> > how the process is described to work vs how it ends up working though. 
> > There has quite been a few times I get conflicting reviews from multiple 
> > reviewers. I suspect either because reviewers are not seeing each others 
> > reviews,

Yes, I've been caught in email storms with hch before, where we're both
firing off emails at the same time and not quite seeing each other's
replies to the same thread.

> > or because it is difficult for people to recall or even find
> > discussions on prior revisions.

Oh gosh yes, lore has been a useful tool for that, but we only got lore
working for linux-xfs (and previous lists) recently.

> > And so at times, I find myself puzzling 
> > a bit trying to extrapolate what the community as a whole really wants.

The bigger problem here is that there are multiple reviewers, each
building slightly different conceptions about a problem and how to solve
that problem, and that's how an author ends up ping-ponging between
reviewers.  Sometimes you can appeal to the maintainer to decide if
integrating the proposed patches are better than not having them, but
sometimes the maintainer is trapped in the M***can standoff.

> The "community as a whole" is not a person and does not have a coherent
> opinion.  You will never please everyone and as you've suggested below,
> it can be hard to tell how strongly people really hold the opinions they
> reveal.
> 
> You need to give up trying to please "the community", but instead develop
> your own sense of taste that aligns with the concrete practice of the
> community, and then please yourself.

The "community as a whole" is not a person and does not have a totally
uniform concrete practice, just like we don't collectively have
identical opinions.  Given a problem description, different people will
choose and reject different high level structures based on their own
experience and biases to solve the problem.  That is how we end up in
the pickle.

> Then when someone criticizes your code, you need to decide for yourself
> whether it is a useful criticism or not.  This might involve hunting
> through the existing body of code to see what patterns are most common.

Our design pattern language changes over time.  For example, we used to
sprinkle indirect function calls everywhere, then I***l screwed us all
over and now those are going away.

> The end result is that either you defend your code, or you change your
> opinion (both can be quite appropriate).  If you change your opinion,
> then you probably change your code too.
> 
> Your goal isn't to ensure everyone is happy, only to ensure that no-one
> is justifiably angry.

Counterpoint: "DAX".

(Allison: I will continue working my way through the rest of your reply
tomorrow morning.)

--D

> NeilBrown
> 
> >
> > For example: a reviewer may propose a minor change, perhaps a style 
> > change, and as long as it's not terrible I assume this is just how 
> > people are used to seeing things implemented.  So I amend it, and in the 
> > next revision someone expresses that they dislike it and makes a 
> > different proposition.  Generally I'll mention that this change was 
> > requested, but if anyone feels particularly strongly about it, to please 
> > chime in.  Most of the time I don't hear anything, I suspect because 
> > either the first reviewer isn't around, or they don't have time to 
> > revisit it?  Maybe they weren't strongly opinionated about it to begin 
> > with?  It could have been they were feeling pressure to generate 
> > reviews, or maybe an employer is measuring their engagement?  In any 
> > case, if it goes around a third time, I'll usually start including links 
> > to prior reviews to try and get people on the same page, but most of the 
> > time I've found the result is that it just falls silent.
> >
> > At this point though it feels unclear to me if everyone is happy?  Did 
> > we have a constructive review?  Maybe it's not a very big deal and I 
> > should just move on.  And in many scenarios like the one above, the 
> > exact outcome appears to be of little concern to people in the greater 
> > scheme of things.  But this pattern does not always scale well in all 
> > cases.  Complex issues that persist over time generally do so because no 
> > one yet has a clear idea of what a correct solution even looks like, or 
> > perhaps cannot agree on one.  In my experience, getting people to come 
> > together on a common goal requires a sort of exploratory coding effort. 
> > Like a prototype that people can look at, learn from, share ideas, and 
> > then adapt the model from there.  But for that to work, they need to 
> > have been engaged with the history of it.  They need the common 
> > experience of seeing what has worked and what hasn't.  It helps people 
> > to let go of theories that have not performed well in practice, and 
> > shift to alternate approaches that have.  In a way, reviewers that have 
> > been historically more involved with a particular effort start to become 
> > a little integral to it as its reviewers.  Which I *think* is what 
> > Darrick may be eluding to in his initial proposition.  People request 
> > for certain reviewers, or perhaps the reviewers can volunteer to be sort 
> > of assigned to it in an effort to provide more constructive reviews.  In 
> > this way, reviewers allocate their efforts where they are most 
> > effective, and in doing so better distribute the work load as well.  Did 
> > I get that about right?  Thoughts?
> >
> > Allison



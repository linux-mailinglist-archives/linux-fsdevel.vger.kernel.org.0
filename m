Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEC83A2A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhFJLei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 07:34:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33118 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJLeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:34:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D40F61FD37;
        Thu, 10 Jun 2021 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623324760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2NY1RK73Mi1SPQVBj3a28xUb0JqOZGt3Jc1mtmQGlc=;
        b=UmDrl/tHuueBHtYY4sk3Dq5T8erLcH3trL8yve+s/hgOoGcKZYOGYjxdf2bQvV0BnwWuXP
        rDnJVUIxjH7nW9BCVzQICJREjMUY+4xAmOfhRgncl6VTKjQTKzUY7+HT2If1hBVFeV0gtE
        VyQ8r65WHL2Zo+YygN7z+gecBo7vyOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623324760;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2NY1RK73Mi1SPQVBj3a28xUb0JqOZGt3Jc1mtmQGlc=;
        b=QUvYS8suwQAyhAIu/e9A3KlcQMuU6r1LSO2PQDeA0wzhUJH3XokBVrDEpa2sSJ1AqizOBw
        s3EhfzXDXA7oYJDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C71EFA3B8E;
        Thu, 10 Jun 2021 11:32:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 978661F2CAB; Thu, 10 Jun 2021 13:32:40 +0200 (CEST)
Date:   Thu, 10 Jun 2021 13:32:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Add pidfd support to the fanotify API
Message-ID: <20210610113240.GC23539@quack2.suse.cz>
References: <cover.1623282854.git.repnop@google.com>
 <CAOQ4uxgR1cSsE0JeTGshtyT3qgaTY3XwcxnGne7zuQmq00hv8w@mail.gmail.com>
 <YMG3crGB2RYZtVmf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMG3crGB2RYZtVmf@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-06-21 16:55:46, Matthew Bobrowski wrote:
> > >   fanotify: add pidfd support to the fanotify API
> > >
> > 
> > This one looks mostly fine. Gave some minor comments.
> > 
> > The biggest thing I am missing is a link to an LTP test draft and
> > man page update draft.
> 
> Fair point, the way I approached it was that I'd get the ACK from all of
> you on the overall implementation and then go ahead with providing
> additional things like LTP and man-pages drafts, before the merge is
> performed.
> 
> > In general, I think it is good practice to provide a test along with any
> > fix, but for UAPI changes we need to hold higher standards - both the
> > test and man page draft should be a must before merge IMO.
> 
> Agree, moving forward I will take this approach.
> 
> > We already know there is going to be a clause about FAN_NOPIDFD
> > and so on... I think it is especially hard for people on linux-api list to
> > review a UAPI change without seeing the contract in a user manual
> > format. Yes, much of the information is in the commit message, but it
> > is not the same thing as reading a user manual and verifying that the
> > contract makes sense to a programmer.
> 
> Makes sense.

I agree with Amir that before your patches can get merged we need a manpage
update & LTP coverage. But I fully understand your approach of trying to
figure out how things will look like before writing the tests and manpage
to save some adaptation of tests & doc as the code changes. For relatively
simple changes like this one that approach is fine by me as well (for more
complex API changes it's often easier to actually *start* with a manpage to
get an idea where we are actually heading). I just want the tests & doc to
be part of at least one submission so that e.g. people on linux-api have a
good chance to review stuff without having to dive into code details.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

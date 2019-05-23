Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B3327FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 16:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfEWOkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 10:40:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:60286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730708AbfEWOkv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 10:40:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AEBFAE4E;
        Thu, 23 May 2019 14:40:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 350351E3C69; Thu, 23 May 2019 16:40:50 +0200 (CEST)
Date:   Thu, 23 May 2019 16:40:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <christian@brauner.io>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
Message-ID: <20190523144050.GE2949@quack2.suse.cz>
References: <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
 <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io>
 <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
 <20190523095506.nyei5nogvv63lm4a@brauner.io>
 <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
 <20190523104239.u63u2uth4yyuuufs@brauner.io>
 <CAOQ4uxji4jRvJnLvXe0yR4Ls7VxM_tjAypX1TqBe5FYr_7GnXw@mail.gmail.com>
 <20190523115845.w7neydaka5xivwyi@brauner.io>
 <CAOQ4uxgJXLyZe0Bs=q60=+pHpdGtnCdKKZKdr-3iTbygKCryRA@mail.gmail.com>
 <20190523133516.6734wclswqr6vpeg@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523133516.6734wclswqr6vpeg@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23-05-19 15:35:18, Christian Brauner wrote:
> So let's say the user tells me:
> - When the "/A/B/C/target" file appears on the host filesystem,
>   please give me access to "target" in the container at a path I tell
>   you.
> What I do right now is listen for the creation of the "target" file.
> But at the time the user gives me instructions to listen for
> "/A/B/C/target" only /A might exist and so I currently add a watch on A/
> and then wait for the creation of B/, then wait for the creation of C/
> and finally for the creation of "target" (Of course, I also need to
> handle B/ and C/ being removed again an recreated and so on.). It would
> be helpful, if I could specify, give me notifications, recursively for
> e.g. A/ without me having to place extra watches on B/ and C/ when they
> appear. Maybe that's out of scope...

I see. But this is going to be painful whatever you do. Consider for
example situation like:

mkdir -p BAR/B/C/
touch BAR/B/C/target
mv BAR A

Or even situation where several renames race so that the end result creates
the name (or does not create it depending on how renames race). And by the
time you decide A/B/C/target exists, it doesn't need to exist anymore.
Honestly I don't see how you want to implement *any* solution in a sane
way. About the most reliable+simple would seem to be stat "A/B/C/target"
once per second as dumb as it is.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

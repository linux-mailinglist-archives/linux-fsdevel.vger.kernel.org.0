Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A7D739C2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 11:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjFVJJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 05:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjFVJIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:08:47 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E99730D7
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 02:00:07 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39eb3af4d8cso4290130b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687424400; x=1690016400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jPSAB1IsF/VpYmXqBS/Ay90kwHTcXo9Cx9zDFJ8+ziU=;
        b=ycoJuwPuH0fNU7QpZXfw4G0SJgU7/eWOxsDi+DHFOUtOJUcbqkREd4Wgb+HEiaX4rG
         nStYztqmuBeIsp/9XQtxHBFVkZkaHcncwvhnv7sxAw+Op2tRla6LadaTlVKBd2uP7oB2
         2qXskmBr7lvibTY6tdkIdsGK/6bN9JcDEw51sNHpanxfu/AkgRvZ5iwUBEq24MZa+nJa
         9f/4gim+B2adRghgqinEFLusFys9UfWnzkCMDcTwJlB44mkASVwri8cq09i+vbJn8B51
         WG1CMOAM7A9wBkffEtmFaHXXCra04QsKRqkdsixAUTX1PJB99OJRedQfz8mU+/YCheTX
         XeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424400; x=1690016400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPSAB1IsF/VpYmXqBS/Ay90kwHTcXo9Cx9zDFJ8+ziU=;
        b=KhBnq/ENAd6wecKrldJklFXYybAjLWQsWp3sxOmhwBa1GmPQ4hmeAelVGPsCXxQS4U
         gF4DmyXL61asec9bBSMPSLVASBkNUwTQ76exEKor1a+od/LOzThqVwDPa0xrIdenUTNx
         GT37sEtyN7V9tfAHILEbg/UwKt3g7OfagwMEmEfLv9ElE5bC0rJWBGx4RjLNARfq1lnT
         O/dij8LquMx0b0FZ0ZuBxbcRMJUhKJAPOJoRZBv/ErS2+/jX8h0kQB+3ZkF9fG3yWpgO
         wLYbH5lcuwmaSKWVIcNxVytNlFdxk4yKEGYkUhM4jYg8mwKqGvkGPM4JBh6tcwcbDoYs
         6Gxw==
X-Gm-Message-State: AC+VfDyLAe9cIIKPV4OEcwc9wezlE8OAFXf4ACIcN8Z1JqTz3XNPBvSY
        9mj7bspHnMkZzuqJY42oyAf59g==
X-Google-Smtp-Source: ACHHUZ4Vh4Xpzv6yUURTmtbS6smTEGwjM3MVIC3+EUzRzo0B3ipbuKGT2tK6Qgn0p86wGjhLxhT54g==
X-Received: by 2002:a05:6808:424d:b0:38e:a824:27d3 with SMTP id dp13-20020a056808424d00b0038ea82427d3mr16982583oib.27.1687424400035;
        Thu, 22 Jun 2023 02:00:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id ev8-20020a17090aeac800b0024e4f169931sm10409008pjb.2.2023.06.22.01.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:59:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qCGAW-00Emvj-0o;
        Thu, 22 Jun 2023 18:59:56 +1000
Date:   Thu, 22 Jun 2023 18:59:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com>,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING: Reset corrupted AGFL on AG NUM. NUM
 blocks leaked. Please unmount and run xfs_repair.
Message-ID: <ZJQNjFJhLh0C84u/@dread.disaster.area>
References: <000000000000ffcb2e05fe9a445c@google.com>
 <ZJKhoxnkNF3VspbP@dread.disaster.area>
 <20230621075421.GA56560@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621075421.GA56560@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 12:54:21AM -0700, Eric Biggers wrote:
> On Wed, Jun 21, 2023 at 05:07:15PM +1000, 'Dave Chinner' via syzkaller-bugs wrote:
> > On Tue, Jun 20, 2023 at 07:10:19PM -0700, syzbot wrote:
> > So exactly what is syzbot complaining about here? There's no kernel
> > issue here at all.
> > 
> > Also, I cannot tell syzbot "don't ever report this as a bug again",
> > so the syzbot developers are going to have to triage and fix this
> > syzbot problem themselves so it doesn't keep getting reported to
> > us...
> 
> I think the problem here was that XFS logged a message beginning with
> "WARNING:", followed by a stack trace.  In the log that looks like a warning
> generated by the WARN_ON() macro, which is meant for reporting recoverable
> kernel bugs.  It's difficult for any program to understand the log in cases like
> this.  This is why include/asm-generic/bug.h contains the following comment:
> 
>  * Do not include "BUG"/"WARNING" in format strings manually to make these
>  * conditions distinguishable from kernel issues.

Nice.

Syzbot author doesn't like log messages using certain key words
because it's hard for syzbot to work out what went wrong.

Gets new rule added to kernel in a comment in some header file that
almost nobody doing kernel development work ever looks at.

Nothing was added to the coding style rules or checkpatch so nobody
is likely to accidentally trip over this new rule that nobody has
been told about.

Syzbot maintainer also fails to do an audit of the kernel to remove
all existing "WARNING" keywords from existing log messages so leaves
landmines for subsystems to have to handle at some time in the
future.

Five years later, syzbot trips over a log message containing WARNING
in it that was in code introduced before the rule was "introduced".
Subsystem maintainers are blamed for not know the rule existed.

Result: *yet again* we are being told that our only option is
to *change code that is not broken* just to *shut up some fucking
bot* we have no control over and could happily live without.

> If you have a constructive suggestion of how all programs that
> parse the kernel log can identify real warnings reliably without
> getting confused by cases like this, I'm sure that would be
> appreciated.  It would need to be documented and then the guidance
> in bug.h could then be removed.  But until then, the above is the
> current guidance.

That is so not the problem here, Eric.

-- 
Dave Chinner
david@fromorbit.com

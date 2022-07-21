Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247F957D45E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiGUTrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 15:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGUTrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:47:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361D322294;
        Thu, 21 Jul 2022 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t+2Pbo5NAhkqaCvz9kmOCN8MxxSQWlhxYZSNcMRXya8=; b=FaEecfr9a5jd2L20DIeYZIpsKS
        ClAy/kzorOmkDirLP7TTYs979JJW6IyuEOmL9hhNK51u/LX00fAWDF69pWOQokY2l65Kuw3gDl144
        FiCulboI67kCI/rOAF0VOR2RYMJBOUupe29k/ff3+HGN6KmTFRSBsggAhgP6gQDulus26dCr88hH2
        g8QgMji47uCaVGNyx1QsTW4e+LY2M993BZiDrqgCLgqnneulygOFG0LlbjYbA37MwZ+jymo4xF5qu
        8589TqUBnuMKtbQYYUlEKdzKXXzINxUs3ixdz1TKEM6KEjvPfq7fSsbrF5JneZsQ9j4NEy8WVNjsg
        hrt3A1rA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEc8Y-00BsAG-6k; Thu, 21 Jul 2022 19:47:06 +0000
Date:   Thu, 21 Jul 2022 12:47:06 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-api@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] proc: fix create timestamp of files in proc
Message-ID: <YtmtOtNp4p0mEARW@bombadil.infradead.org>
References: <20220721081617.36103-1-zhangyuchen.lcr@bytedance.com>
 <Ytl772fRS74eIneC@bombadil.infradead.org>
 <87wnc6nyux.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnc6nyux.fsf@email.froward.int.ebiederm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 21, 2022 at 12:45:42PM -0500, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > On Thu, Jul 21, 2022 at 04:16:17PM +0800, Zhang Yuchen wrote:
> >> A user has reported a problem that the /proc/{pid} directory
> >> creation timestamp is incorrect.
> >
> > The directory?
> 
> A bit of history that I don't think made it to the git log is that
> procps uses the /proc/<pid> directory, to discover the uid and gid of the
> process.

Oy vei.

In that sense, if *really* the directory for a PID all of a sudden
disappear and reapper with another time stamp, I wonder if its
possible to change the uid/gid.

> I have memories of Albert Cahalan reporting regressions because I
> had tweaked the attributes of proc in ways that I expected no
> one would care about and caused a regression in procps.

Thanks for bringing this little bit of history to light.

> So it is not unreasonable for people to have used proc in surprising
> ways.
> 
> I took a quick read through procps and it looks like procps reads
> /proc/<pid>/stat to get the start_time of the process.

OK so at least for that world of userspace *if* indeed the pid directory
is changing time somehow (the exact way in which this can happen as
reported is yet to be determined) the existing procps would *not* have
been affected.

If *procps* is not being used and someone is trying to re-implement it,
and if indeed it is using the time of the inode, and *if* this really
can change, then we have an explanation to the current situation.

> Which leads us to this quality of implementation issue that the time
> on the inode of a proc directory is the first time that someone read
> the directory and observed the file.  Which does not need to be anything
> at all related to the start time.

Best I think we can do, is document this, and if we *want* to accept
a *new mechanism*, add a kconfig entry so to distinguish this, so to
not break old reliance on prior behaviour.

> I think except for the symlinks and files under /proc/pid/fd and
> /proc/pid/fdinfo there is a very good case for making all of the files
> /proc/pid have a creation time of equal to the creation of the process
> in question.

A new kconfig entry could enable this. But that still would not
prevent userspace from modifying file's creation time and I'm not
sure why we'd want to change things.

> Although the files under /proc/pid/task/ need to have
> a time equal to the creation time of the thread in question.
> 
> Improving the quality of implementation requires caring enough to make
> that change, and right now I don't.

My biggest fear is breaking things.

If we *really* are somehow modifying the timestamp of the directory
inode though, I'd like to understand how that happened.

> At the same time I would say the suggested patch is a bad idea.
> Any application that breaks because we hard set the timestamp on a proc
> file or directory to the beginning of time is automatically counts as a
> regression.

It is why I was seriously confused, why would someone purposely try to
create a regression.

> Since the entire point of the patch is to break applications that are
> doing things wrong, aka cause regressions I don't think the patch
> make sense.

And hence my serious distaste for it.

> So I would vote for understanding what the problem user is doing.  Then
> either proc can be improved to better support users, or we can do
> nothing.
> 
> Except for explaining the history and how people have legitimately used
> implementation details of proc before, I am not really interested.  But
> I do think we can do better.

Thanks for the feedback.

  Luis

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42777B822C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjJDOXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjJDOXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:23:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC0C4
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 07:23:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDDDB1F38A;
        Wed,  4 Oct 2023 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696429427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHb/a3BAxQGZndtORH0UCfwT2Tjg3D0onRWIB4VDNv0=;
        b=NQ2m09+eoeyOldzeU7SnmNZrATJsUEmCM/SKqPXBIEEcv4f3UpFqic66vnfWg6TuKtUo5j
        G7/lb0lYwApQKhpbg2h2VMLcnOGALCZ5lhW4dKfWV4ObO0PNep9rQQ39+rmjnAh+iNzZZc
        8Ca7hSTqGcNjtQQzafZFT/5iqKvqgGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696429427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHb/a3BAxQGZndtORH0UCfwT2Tjg3D0onRWIB4VDNv0=;
        b=6aMOd8elijYE0oYQUMq7AmmhFN6X27xSwyrOMbTa8R0wZZ+T1IH6jC9SvcokNBqUJu3Rm4
        rByPfKCEZfznGyBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F4ED139F9;
        Wed,  4 Oct 2023 14:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AJphFXN1HWWjdwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 04 Oct 2023 14:23:47 +0000
Date:   Wed, 4 Oct 2023 16:24:30 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     ltp@lists.linux.it, Matthew Wilcox <willy@infradead.org>,
        mszeredi@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Reuben Hawkins <reubenhwk@gmail.com>
Subject: Re: [PATCH 2/3] syscalls/readahead01: Make use of tst_fd_iterate()
Message-ID: <ZR11nlq3Le1GAwcd@yuki>
References: <20231004124712.3833-1-chrubis@suse.cz>
 <20231004124712.3833-3-chrubis@suse.cz>
 <CAOQ4uxg8Z1sQJ35fdXnct3BJoCaahHoQ9ek3rmPs3Ly8cVCz=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg8Z1sQJ35fdXnct3BJoCaahHoQ9ek3rmPs3Ly8cVCz=A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> > TODO: readahead() on /proc/self/maps seems to succeed is that to be
> >       expected?
> 
> Not sure.
> How does llseek() work on the same fd?

Looks like we we can seek in that file as well, accordingly to man pages
we cannot seek in pipe, socket, and fifo, which seems to match the
reality.  We can apparently seek in O_DIRECTORY fd as well, not sure if
that is even useful.

> > -static void test_invalid_fd(void)
> >  {
> >         int fd[2];
> >
> > -       tst_res(TINFO, "%s pipe", __func__);
> > +       TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF,
> > +                    "readahead() with fd = -1");
> > +
> 
> Any reason not to include a bad and a closed fd in the iterator?

I wanted to avoid mixing valid and invalid fds because we tend to get
different errnos for these, since the situation is different between
"this is not a file descriptor" and "this is not supported on this kind
of file descriptor".

> >         SAFE_PIPE(fd);
> > -       TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
> >         SAFE_CLOSE(fd[0]);
> >         SAFE_CLOSE(fd[1]);
> >
> > -       tst_res(TINFO, "%s socket", __func__);
> > -       fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> > -       TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
> > -       SAFE_CLOSE(fd[0]);
> > +       TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EBADF,
> > +                    "readahead() with invalid fd");
> > +}
> > +
> > +static void test_invalid_fd(struct tst_fd *fd)
> > +{
> > +       switch (fd->type) {
> > +       case TST_FD_FILE:
> > +       case TST_FD_PIPE_OUT:
> > +               return;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       TST_EXP_FAIL(readahead(fd->fd, 0, getpagesize()), EINVAL,
> > +                    "readahead() on %s", tst_fd_desc(fd));
> 
> Thinking forward and we would like to change this error code to ESPIPE
> is there already a helper to expect one of a few error codes?

Not yet. The hardest part is again figuring out right API. We usually
try to check for the new behavior on newer kernels, which would be
complex to encode into the parameters, so maybe we just need to pass a
callback that would return the right errno. Maybe something as:

static int exp_errno(void)
{
	if (tst_kvercmp(6, 7, 0) >= 0)
		return ESPIPE;

	return EINVAL;
}

...
	TST_EXP_FAIL_CB(readahead(fd->fd, 0, getpagesize()), exp_errno,
		"readahead() on %s", tst_fd_desc(fd));
...

-- 
Cyril Hrubis
chrubis@suse.cz

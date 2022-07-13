Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B80572B9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 04:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiGMC6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 22:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGMC6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:58:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9369108
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 19:58:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id os14so17571349ejb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 19:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYXkNjj4OKSo0CHI0vesWcyKBi2MUfhbVACz4mBS38U=;
        b=W2X1vb5OyE/z2tYTrugmQ+bR4WwI1+DDo3dUQShjSpawUd1Ds074Vn8Gec33JrSD/e
         xUpOdpN6hAGt9mJZNeRsTVBE10ylVuKSE/wBt0cZl6LZmrb9wprUBRpnBA44YOCdjHYQ
         tTeAsvrKIpVGVi6r+/OLTwP/ZQn2VeQlcEZhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYXkNjj4OKSo0CHI0vesWcyKBi2MUfhbVACz4mBS38U=;
        b=oW3punQFeuCtepDsWsbE2Q6aNPfhD7bQHe1v87YV+Ur/N/srelbBK2Ib7Lf+UzFAa4
         DldsvhQPRqjYqO8A5uqXaYi9dUgzVmWv6CaIyC/JGLELk6fJ4rBMl9jJ33OG66q6a188
         riImVDduk3Z2bBjbbMbeZx7V1F+OU0EUo25kmw1HgO9VJLmJikDYOxs73If178yth5dN
         HbTfxU6RwsKAgOZRqq9yUMZumjiZzteWzd8D5MO+RQ5h8dg1GYoAhg4gggbxJ6iIJ18A
         cwUj0o5SGvZSSiJG5dKm8u63VH1uo6DeYA/5OqdCWkG/M6emt1xuZ6NVC/xpT9Jud4pt
         7lkg==
X-Gm-Message-State: AJIora/QhDaerGxRk2trBBXu+d81dYLnAfzQg64za3U+06h7deVJcdaX
        M71Fs71EO5ar4vyJtfhIPHXnkfzxXwiJ7iOjqkw=
X-Google-Smtp-Source: AGRyM1vchPBo5iNVoFZ6H2L6qgLM7LIZW0vLtZLedrGCaR0aFPPT5R1kRZfAnXuVcynISPRo2iYoTA==
X-Received: by 2002:a17:907:3e13:b0:726:eebc:3461 with SMTP id hp19-20020a1709073e1300b00726eebc3461mr1192001ejc.528.1657681110164;
        Tue, 12 Jul 2022 19:58:30 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id q18-20020a056402041200b0043a7c24a669sm7072091edv.91.2022.07.12.19.58.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 19:58:28 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id v16so13589604wrd.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 19:58:28 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr965565wrw.274.1657681107957; Tue, 12 Jul
 2022 19:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain> <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia>
In-Reply-To: <Ys4WdKSUTcvktuEl@magnolia>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 12 Jul 2022 19:58:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
Message-ID: <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        ansgar.loesser@kom.tu-darmstadt.de, Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 5:48 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> AFAICT, the reason why dedupe does all the weird checks it does is
> because apparently some of the dedupe tools expect that they can do
> weird things like dedupe into a file that they own but haven't opened
> for writes or could open for writes.  Change those bits, and you break
> userspace.

Christ, what a crock.

> The dedupe implementations /do/ check file blocksize, it's under
> generic_remap_file_range_prep.  The reason this exploit program works on
> the 7-byte file is that we stop comparing at EOF, which means that there
> are fewer bytes to guess.  But.  You can already read the file anyway.

The dedupe clearly does *not* check for blocksize. It doesn't even
call generic_remap_file_range_prep().

Just check it yourself:

    do_vfs_ioctl ->
        case FIDEDUPERANGE:
         ioctl_file_dedupe_range(filp, argp) ->
            vfs_dedupe_file_range(file, same) ->

and there it is. All that calls is remap_verify_area() for both files,
and allow_file_dedupe() for the target.

Now, maybe some filesystem then calls the checking functions, but
considering the posted code, that can't be true, because no, the  the
whole EOF argument is garbage, because even if the *source* was at
EOF, the destination offset should still have been checked for being
at a block boundary.

And it clearly wasn't, since the code just walks the destination
offset one byte at a time.

So you may *think* that it checks the file blocksize, but I'm afraid
reality disagrees.  And no amount of "source is at EOF" is possibly
relevant for the destination block size check.

> So we're going to break userspace?
> https://github.com/markfasheh/duperemove/issues/129

Well, if you're supposed to be able to dedupe read-only files, then
the whole "check for writing" is just bogus to begin with.

So in no way are any of those checks possibly correct.

The destination offset is clearly not checked at all.

And if writability isn't something you want honored, then FMODE_WRITE
shouldn't have been an issue.

> ...and we're going to break deduping the EOF block again?

Why are you arguing about something that is clearly broken.

The lack of destination offset checking cannot possibly be rigth. No
amount of "EOF block" is relevant AT ALL.

Stop it. You're making an argument that has nothing to do with the bug at hand.

> What /is/ the meaning of S_IMMUTABLE?  Documentation/ only says that the
> fsverity author thinks it means "read-only contents".  If it's the same
> as "chmod 0000" in that anyone with a writable fd can still modify the
> supposedly immutable file, then what was the point?

No, the whole point is that you cannot ever get a writable file
descriptor to an immutable file.

So if that FMODE_WRITE check is correct, then IS_IMMUTABLE is nonsense.

And if MODE_WRITE isn't correct, and dedupe is considered a read-only
operation, then *that* isn't valid.

You can't have it both ways. Which is it?

That's really my point here - all those checks are completely random
noise. There is absoltuely no rhyme or reason to them.

And the offset check is clearly not there, and you should stop talking
about "source EOF", because that is irrelevant. Source EOF may affect
the *length* of the block, but it does not affect the offset of the
destination.

               Linus

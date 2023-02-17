Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB0469B200
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 18:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBQRso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 12:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBQRsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:48:43 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412854FCBD;
        Fri, 17 Feb 2023 09:48:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bi36so2414239lfb.6;
        Fri, 17 Feb 2023 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W82mtufaxCxYaCrOwsWwXEqkQ8P4m8alQaSwlsBKCQE=;
        b=RimT2oCov4P2FJhzEMVzK6vAiZ1gzLQ+s2iyY+NBElRkyquEhBySqKaTrFiClN3Q5L
         tc4BrLdaY/OzDcL8amvmaZWPWdQ29gctSOMhZYz00WwaVG+tKgqs9a0ZOrPBcQdOZauU
         4eHv8uCS2ezA6q1tCzEtShJ0lcitKPXVnXs6b4z+J2wS0/IRMtfn/yjH0SSTaPK9A/J5
         2ELTVzNKbzdyrKU0wEKbfPTf629znz/I3HfzV0bSoeErirN2hQn6zDbQJwkEZSod+M5s
         2XzWNrgf/6UxcM1LExMCpG3ohyVuDIhCxkEmyopQDxfD7YU5yQXzh/3R+DznDDXV4yjr
         Yz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W82mtufaxCxYaCrOwsWwXEqkQ8P4m8alQaSwlsBKCQE=;
        b=Q0fGN7ApykI008wSYWbeAIuOAEtDywXpMjpU7ET1aPyznALkWYnb4/g+L5Wmm5A7s3
         nh+khoGnoAfIDYtyPn8N0vF2/Vf1hH2XUrDvLzHgmeKtvVaYji+EUrLi06qq+NQrs5GL
         18No2Dqt6gRzuMSHZV+P3d9+i6bbg+XVI7wlfPr98x+IxU86qlo0GrsDqke7oDILXAIY
         LLSZnTZIh5spCRgObRha9Bu1VwEX+57rix1ibUBMmkbxwAhO6ghPA+n4YWhkVFVz1MlH
         gsa8OYoxfVuUOvr4eVDSoeYaOn9UsceCigLHTRFMx99ykk2cE5HhBGapIQ1FSuN+D7yr
         w8dQ==
X-Gm-Message-State: AO0yUKWROb3peoP3KSMITkZVNo05SyoZAMQPAFH8adBq83wB71IuodXr
        IyUAxDUxDy4RLldrKKO2+cG8haXifGuNrS3lX40=
X-Google-Smtp-Source: AK7set86i6m3Q4viJu7w21vbC25QAPfZIb1xUe2TG6mkfmZTyneWDww3gkbjTM2kzGZ0bcI9FudMJJy97KppSFxu5AQ=
X-Received: by 2002:a05:6512:501:b0:4d5:ca32:7bc3 with SMTP id
 o1-20020a056512050100b004d5ca327bc3mr646949lfb.10.1676656120238; Fri, 17 Feb
 2023 09:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20230216214745.3985496-1-dhowells@redhat.com> <20230216214745.3985496-15-dhowells@redhat.com>
 <CAH2r5msNJTdt7295xt=NVY7wUaWFycKMb_=7d9LySsGGwBTnjQ@mail.gmail.com> <4008035.1676621321@warthog.procyon.org.uk>
In-Reply-To: <4008035.1676621321@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 17 Feb 2023 11:48:28 -0600
Message-ID: <CAH2r5ms1u7OPYhzYHLD2vddK6FHxOR3q+O_n80JmbJeo_mbUMQ@mail.gmail.com>
Subject: Re: [PATCH 14/17] cifs: Change the I/O paths to use an iterator
 rather than a page list
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I don't think that those are particular important to clean up - but a
couple of the other checkpatch warnings were

On Fri, Feb 17, 2023 at 2:08 AM David Howells <dhowells@redhat.com> wrote:
>
> Steve French <smfrench@gmail.com> wrote:
>
> > WARNING: Consider removing the code enclosed by this #if 0 and its #endif
> > #627: FILE: fs/cifs/file.c:2609:
> > +#if 0 // TODO: Remove for iov_iter support
> > ...
> > WARNING: Consider removing the code enclosed by this #if 0 and its #endif
> > #1040: FILE: fs/cifs/file.c:3512:
> > +#if 0 // TODO: Remove for iov_iter support
> >
> > WARNING: Consider removing the code enclosed by this #if 0 and its #endif
> > #1067: FILE: fs/cifs/file.c:3587:
> > +#if 0 // TODO: Remove for iov_iter support
> >
> > WARNING: Consider removing the code enclosed by this #if 0 and its #endif
> > #1530: FILE: fs/cifs/file.c:4217:
> > +#if 0 // TODO: Remove for iov_iter support
> >
> > WARNING: Consider removing the code enclosed by this #if 0 and its #endif
> > #1837: FILE: fs/cifs/file.c:4903:
> > +#if 0 // TODO: Remove for iov_iter support
>
> These chunks of code are removed in patch 16.  I did it this way to reduce the
> size of patch 14.  I can merge 16 into 14 if you like.
>
> David
>


-- 
Thanks,

Steve

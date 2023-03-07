Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD60F6AD3D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCGBYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCGBY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA66E89
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 17:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678152220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VqFd56y4+LzHfJxq40JHsrzkzmxYaLDJMh6dCS+VZKQ=;
        b=C0kAeLZ4m80kQ4W4REDmVUtUNvdH71ufoL66+MFJQcGyuqIkGfNppwFbe4jSHyzbvaQnyj
        t6xAqIUceq+fI32Pio566tw018E1mehq4s2XcmtiGgimP8DkQojH2Wr+koeHkdsho8PX2Y
        Imuov6DiiRJ8Uqa3mDmjklKLEbbdtCY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-tyl07KeNOn2ML-TyqfK8-Q-1; Mon, 06 Mar 2023 20:23:39 -0500
X-MC-Unique: tyl07KeNOn2ML-TyqfK8-Q-1
Received: by mail-qk1-f199.google.com with SMTP id e14-20020a05620a208e00b0074270b9960dso6509247qka.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 17:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678152218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqFd56y4+LzHfJxq40JHsrzkzmxYaLDJMh6dCS+VZKQ=;
        b=4H7LzAYMg8qwrsmdQ1zeBrXqs24dlzWqA1K3JcziZ1E33BnzA/z1uvE75F6ttmAPE7
         RqUlwiSyhUeUmA0Vfs9nM67dUY1sRyvY+Cr07qroTfCN6Z8Ms7XGSEAhmJJpPzwQ30fH
         BxGUfIHJ9+DcPPb7pbiScoFJAUe0QfCTYKxzJcCFXveQvQgfRCVKeEFs5ZXR+FT0QQ/j
         czV7u+1SUV7XR5VVIb1rBPp0BcpLUAMDfPJqrvLwu0kAwIjeOsljismNEPMfarsQNJEq
         zfY04HaPXq9L08e5h1TgmfQI3yIOnPaM5WGjYlQbkiYtyZ2u0yOLjg/LfdgKqR9JfCA8
         Mjpg==
X-Gm-Message-State: AO0yUKXVbgeJ8xymtqnkTNJaTzvtOIQrGOsfvdzCHibC3YwxoVt5DtQ+
        7xDmYymnrorlqYAJmOi2PwL1bbKCkCTbbWlWKQdiD+NSON8q1F5mwwj/JF2kGY41GV+M1X4HZAR
        9r+q8N+7MBNLb+xWAMZeDkvu2y3q3hv8UCA==
X-Received: by 2002:ac8:4e49:0:b0:3b6:309e:dfe1 with SMTP id e9-20020ac84e49000000b003b6309edfe1mr22807073qtw.3.1678152218570;
        Mon, 06 Mar 2023 17:23:38 -0800 (PST)
X-Google-Smtp-Source: AK7set9NpW+IRYzeTwvzpjcmeG0lCpLiSMH4ix2ZZfLC9vuxmSNZLU9/wHTDN/VWK1ddDO5/7LNY8w==
X-Received: by 2002:ac8:4e49:0:b0:3b6:309e:dfe1 with SMTP id e9-20020ac84e49000000b003b6309edfe1mr22807045qtw.3.1678152218368;
        Mon, 06 Mar 2023 17:23:38 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id e15-20020ac85dcf000000b003bfad864e81sm8708948qtx.69.2023.03.06.17.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:23:37 -0800 (PST)
Date:   Mon, 6 Mar 2023 20:23:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 5/5] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to
 install WP PTEs
Message-ID: <ZAaSGGzylNFCR+ql@x1n>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306225024.264858-6-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:50:24PM -0800, Axel Rasmussen wrote:
> UFFDIO_COPY already has UFFDIO_COPY_MODE_WP, so when installing a new
> PTE to resolve a missing fault, one can install a write-protected one.
> This is useful when using UFFDIO_REGISTER_MODE_{MISSING,WP} in
> combination.
> 
> So, add an analogous UFFDIO_CONTINUE_MODE_WP, which does the same thing
> but for *minor* faults.
> 
> Update the selftest to do some very basic exercising of the new flag.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Some mentioning on the use case would be nice. :) No objection having it.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


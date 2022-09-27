Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE36C5EC4F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiI0Nv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiI0Nv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:51:57 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEEF125DAB;
        Tue, 27 Sep 2022 06:51:56 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3B4CC41203;
        Tue, 27 Sep 2022 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1664286714; x=1666101115; bh=djkTMrw3NuDNUlcbgKWdUAMdOE33vBB/qXd
        2X5QY5YE=; b=iMmU13TmtIETymKDE54w7K8dAQmy2j5wKzhW8LlTZCXsKIT0c+p
        5yvIgsyLroZOUqfZEqEI1yaxHw8Bd3gIAiGssPBeZ54agqJvg4sBBrItDOdGOLmL
        +9Z8AISJyaqRsyMLv2uWyDd5+z7ve944JY2yce7ksuElvPdY0hn3K0KY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KZtp7uwSd8tN; Tue, 27 Sep 2022 16:51:54 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (T-EXCH-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A558C40355;
        Tue, 27 Sep 2022 16:51:53 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 27 Sep 2022 16:51:53 +0300
Received: from yadro.com (10.199.23.254) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 27 Sep
 2022 16:51:52 +0300
Date:   Tue, 27 Sep 2022 16:51:50 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Miguel Ojeda <ojeda@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <patches@lists.linux.dev>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v10 08/27] rust: adapt `alloc` crate to the kernel
Message-ID: <YzL/9mlOHemaey2n@yadro.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-9-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-9-ojeda@kernel.org>
X-Originating-IP: [10.199.23.254]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:39PM +0200, Miguel Ojeda wrote:
[...]
> +    /// Tries to append an element to the back of a collection.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut vec = vec![1, 2];
> +    /// vec.try_push(3).unwrap();
> +    /// assert_eq!(vec, [1, 2, 3]);
> +    /// ```
> +    #[inline]
> +    #[stable(feature = "kernel", since = "1.0.0")]
> +    pub fn try_push(&mut self, value: T) -> Result<(), TryReserveError> {
> +        if self.len == self.buf.capacity() {
> +            self.buf.try_reserve_for_push(self.len)?;
> +        }
> +        unsafe {
> +            let end = self.as_mut_ptr().add(self.len);
> +            ptr::write(end, value);
> +            self.len += 1;
> +        }
> +        Ok(())
> +    }
[...]

Not being able to pass GFP flags here kinda limits the scope of Rust in
kernel. I think that it must be supported in the final version that gets
in.

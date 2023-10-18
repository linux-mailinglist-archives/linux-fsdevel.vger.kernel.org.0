Return-Path: <linux-fsdevel+bounces-673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10337CE33B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDBA1C20DAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCAD3C09D;
	Wed, 18 Oct 2023 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TtO3EzMJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514A3B7A3;
	Wed, 18 Oct 2023 16:57:40 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04A8FA;
	Wed, 18 Oct 2023 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MA/2Dc3ShbOWrwa6b8+ntb/0UMgutIZF7cKgba1BZtQ=; b=TtO3EzMJ7EMiJ+pUl91IN6H54l
	qO/yLCQAI5nBUoruQSQ9eeq7qED8OpgiYmclCkyjKFcghy/uRhMubvUuXU4yehI5p9os20AHXvMqX
	ob25zMbPpMv/N54tsz3trstAf6rq1ooWynsI+cu8MFvp9KuV/EH2sQn2viErHGV9B2ZTBUxn39FSL
	I0vzfxzieJdVXz4lD7u572CXJcvTVv36owZyhO4gPfYd5dejUlmDrhA5XWvQNcGhvnkSGE9lQVgAb
	vfiNgws4Vs+Qepq0kbHPh7x9ZWD/rN2e2C0sRBuYxHFJAacR5OEGfqsDal/hH8Pb5KxUk0UUw8Kvo
	0GKkEmNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qt9rR-00225j-12; Wed, 18 Oct 2023 16:57:33 +0000
Date: Wed, 18 Oct 2023 17:57:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 19/19] tarfs: introduce tar fs
Message-ID: <ZTAOfMvegVAc58Yn@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-20-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018122518.128049-20-wedsonaf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 09:25:18AM -0300, Wedson Almeida Filho wrote:
> +    fn read_folio(inode: &INode<Self>, mut folio: LockedFolio<'_>) -> Result {
> +        let pos = u64::try_from(folio.pos()).unwrap_or(u64::MAX);
> +        let size = u64::try_from(inode.size())?;
> +        let sb = inode.super_block();
> +
> +        let copied = if pos >= size {
> +            0
> +        } else {
> +            let offset = inode.data().offset.checked_add(pos).ok_or(ERANGE)?;
> +            let len = core::cmp::min(size - pos, folio.size().try_into()?);
> +            let mut foffset = 0;
> +
> +            if offset.checked_add(len).ok_or(ERANGE)? > sb.data().data_size {
> +                return Err(EIO);
> +            }
> +
> +            for v in sb.read(offset, len)? {
> +                let v = v?;
> +                folio.write(foffset, v.data())?;
> +                foffset += v.data().len();
> +            }
> +            foffset
> +        };
> +
> +        folio.zero_out(copied, folio.size() - copied)?;
> +        folio.mark_uptodate();
> +        folio.flush_dcache();
> +
> +        Ok(())
> +    }

Who unlocks the folio here?


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632AB26DE2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgIQOZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 10:25:19 -0400
Received: from verein.lst.de ([213.95.11.211]:56535 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbgIQOY7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:24:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8BA4668C65; Thu, 17 Sep 2020 16:14:40 +0200 (CEST)
Date:   Thu, 17 Sep 2020 16:14:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20200917141439.GC27653@lst.de>
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com> <87h8rki2iu.fsf@evledraar.gmail.com> <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com> <20180117235220.GD6948@thunk.org> <87sgbghdbp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgbghdbp.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 01:06:50PM +0200, Ævar Arnfjörð Bjarmason wrote:
> The reason is detailed in [1], tl;dr: empty loose object file issue on
> ext4 allegedly caused by a lack of core.fsyncObjectFiles=true, but I
> didn't do any root cause analysis. Just noting it here for for future
> reference.

All the modern Linux file systems first write the data, and then only
write the metadata after the data write has finished.  So your data might
have been partially or fully on disk, but until the transaction to commit
the size change and/or extent state change you're not going to be able
to read it back.

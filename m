Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE70573BD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 19:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiGMRPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGMRPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:15:11 -0400
Received: from mail-relay232.hrz.tu-darmstadt.de (mail-relay232.hrz.tu-darmstadt.de [130.83.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4C42BB1F
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 10:15:10 -0700 (PDT)
Received: from smtp.tu-darmstadt.de (mail-relay158.hrz.tu-darmstadt.de [130.83.252.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mail-relay158.hrz.tu-darmstadt.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by mail-relay232.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4LjklF3klJz43pb;
        Wed, 13 Jul 2022 19:15:05 +0200 (CEST)
Received: from [IPV6:2001:41b8:810:20:8488:f081:d781:11f2] (unknown [IPv6:2001:41b8:810:20:8488:f081:d781:11f2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by smtp.tu-darmstadt.de (Postfix) with ESMTPSA id 4Ljkl94DQGz43VZ;
        Wed, 13 Jul 2022 19:15:01 +0200 (CEST)
Message-ID: <13861bb3-84d6-634a-13fe-8b7a626aa147@tu-darmstadt.de>
Date:   Wed, 13 Jul 2022 19:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   =?UTF-8?B?QW5zZ2FyIEzDtsOfZXI=?= <ansgar.loesser@tu-darmstadt.de>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly
 files
Reply-To: ansgar.loesser@kom.tu-darmstadt.de
To:     Linus Torvalds <torvalds@linuxfoundation.org>,
        ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=c3=b6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Header-TUDa: 2XgpqppAsreLPAgSwy4NiU58w+fLPvy6Gf9Q51S5mu3i393tLs8B5jvDYMOFrxtj6r38fvvnbKUDlzsjKJLXk/tp/VWtzLF6PwnTBt
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> First off - an odd technicality: you can already read write-only files
> by simply mmap'ing them, because on many architectures PROT_WRITE ends
> up implying PROT_READ too.
> 
> So you should basically expect that "I have permissions to write to
> the file" automatically means that you can read it too.
> 
> People simply do that "open for writing, mmap to change it" and expect
> it to work - not realizing that that means you have to be able to read
> it too.

Thank you for the explanation. Unfortunately I was not able to reproduce 
this. I do understand, that being able to write to memory without being 
able to read from it cannot be implemented because of hardware 
limitations on many architectures.

However using a writeonly fd in a call to mmap() in the first place 
already consistently fails for me. According to the man pages this is 
actually intended behavior. "Errors: EACCESS: [... If] a file mapping 
was requested, but fd is not open for reading."

Therefore I do not see how it is possible to read out data without a 
readable fd, since no mapping can be created without read permissions. I 
assumed readability not being a subset of writability for files was the 
exact reason for this limitation on the fd in mmap(). Do I miss 
something here?

> But
> 
>> -    if (!inode_permission(mnt_userns, inode, MAY_WRITE))
>> +    if (!inode_permission(mnt_userns, inode, MAY_READ | MAY_WRITE))
> 
> looks wrong.
> 
> Note that readability is about the file *descriptor*, not the inode.
> Because the file descriptor may have been opened by somebody who had
> permission to read the file even for a write-only file.

I do agree. At least it did not look typical for me. The idea for the 
patch was simply to have the smallest possible change for this specific 
issue.

Best regards,
Ansgar

-- 
M.Sc. Ansgar Lößer
Fachgebiet Kommunikationsnetze
Fachbereich für Elektrotechnik und Informationstechnik
Technische Universität Darmstadt

Rundeturmstraße 10
64283 Darmstadt

E-Mail: ansgar.loesser@kom.tu-darmstadt.de
http://www.kom.tu-darmstadt.de

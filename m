Return-Path: <linux-fsdevel+bounces-13740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000487355A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7D21F24D0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70147641F;
	Wed,  6 Mar 2024 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbIQAJkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB637745E0;
	Wed,  6 Mar 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723367; cv=none; b=ilmt9Jg9aCgh9L/Hnpto8TNuz6MD31v59rmpL/a2Yct0dB70/mYy6j4MwYcvhmgGn6jKDFi2vzqaUU43x/0heEYLqW+n8VYBjXwYq1atyeRTGlyPJLx00OYGjvRQ8m6Llpxvka3y2npQq64NxTBxtOufGjxIoS8ZGiylFeYEcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723367; c=relaxed/simple;
	bh=wfchAnSpZhoq9w6pqknAMA6sRlQ5/ydgV1sHI2Pc4x0=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=XLJ6ddym/OUuiVLnx+Hp5JD5WdJDrEzHg8yjz64PNZNoE+DDjaCXZmugbbRlXTChyCoIWJlxsl3TZ/Q6b5f2O/I3TVqbdc3VdNQLZYjGHX/XSR9hDCTAHhwLdEE6gt8CKJQ0zXGER7UqmT9B0bWci4nvnWmyvOuDKtf4ssKbz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbIQAJkQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dcc7f4717fso66612875ad.0;
        Wed, 06 Mar 2024 03:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709723364; x=1710328164; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PBoe297NLuGYbL60WKlTKgt6ML8FWLv2cO3sE0MvVJI=;
        b=jbIQAJkQrggNPOUj2LEJ7/2bgr/dmBHWetKatbMqxCUwNSNlnV8KMK7LDwW1hHRlyg
         s+KbUh5c1XwJc3UEn4os/fr8rZ0UZVvHH7FCBiUccFHkdhs8bUaEyID7a7/P/NBK6HgS
         ckK9QL4E7LM6lzCB7gkLiQ3DwyWuJ9lo68wHL/R5qJ3uCPU5gGPxqUzStxhyh8jiBrHr
         fOaGSBo78m1Snqo8DT0kKU49tH81og6A39vfL9AIxd4WJKcDdOryPGXiPyNdxUwJxwxF
         ANALo3ID7vca+/GQD/pN5nGlqk35KcgMCHO79/8uwPDSidaBgbUZ81MDFEOww4CADJV9
         AvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709723364; x=1710328164;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBoe297NLuGYbL60WKlTKgt6ML8FWLv2cO3sE0MvVJI=;
        b=uLfi5yxiEhJK6P2/B/97nIWtKhpQNuh7sBXVUUbP/XG03sS1EpDPtoibXgfdcKNsme
         nmEcf7QP/cXLxCGDZVwxSSaiZphYOVGYZ4jLQBIwNdURO9P67Hatm58PVrfgO+fVU9ZI
         XiJd2fP0a/uQIy4wxFVybP1lbQr8JbIJ+p9AljXXYGRfAtLUN5eD3paGkRHc3FCwIMer
         aqHenJtDnG1Rv6xZPdKN7pZFb+WnshqIKh80tW9A4Cm929fanHnu2EZfpZ5ozvOiTod8
         6VCKItJfgbKdN6KAIK8DX+yyAvj/sYX4OtZ5pJTtW4Jms52SywwdUjeTPRHKW9PaP5b6
         LU2g==
X-Forwarded-Encrypted: i=1; AJvYcCVxdUiUO4vKjguLlVzQkmnL10VO0wbkzqR4JF+PEYt5brr4SRwOaag5FwgDCFYhuVk7jxZPj9yd5oRBnBQsKP86afUwYQ0SpPvBoA==
X-Gm-Message-State: AOJu0YzSuu0Un5QcETIdK0fnDw8tC90F9NXDDVtD9Zt8n3YT0RD5IUoC
	FtFtVlzExawOByGPbJtU4HZIN+SPXtNJyo9Xo08FrkYY8R/ef32Lxys9PYw0CXQ=
X-Google-Smtp-Source: AGHT+IFyzL/WTr93rRFCL0u84YjmMmbhZw7ocawk8y05EWyU60nUgRNUfZPL6wBlD4fb2SoidpEl0w==
X-Received: by 2002:a17:903:1104:b0:1dc:cbc0:1971 with SMTP id n4-20020a170903110400b001dccbc01971mr5144326plh.49.1709723364374;
        Wed, 06 Mar 2024 03:09:24 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001dcfc8a5fafsm8215516plg.96.2024.03.06.03.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 03:09:23 -0800 (PST)
Date: Wed, 06 Mar 2024 16:39:20 +0530
Message-Id: <87le6vpqfz.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, linux-ext4@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC]: Challenges and Ideas in Transitioning EXT* and other FS to iomap
In-Reply-To: <87y1ba17x0.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
>
> ++ linux-ext4
>
>> In continuation from last year's efforts on conversion of ext* filesystems to iomap,
>> I would like to propose an LSFMM session on the said topic. Last year's session
>> was mainly centered around documentation discussion around iomap (so that it can help others
>> converting their filesystems to iomap), and I think we now have a kernelnewbies page [1] 
>> which can provide good details on how one can start transitioning their filesystem to iomap
>> interface.
>>
>> Note, ext2/ext4 filesystems direct-io path now utilizes iomap where ext2
>> DIO conversion happened last year during LSFMM [2] [3]. I have also submitted patches
>> for ext2 buffered-io path for regular files to move to iomap and thereby enabling
>> large folio support to it. Along similar lines there are also patches around EXT4
>> buffered-io conversion to iomap.
>>
>> Some of the challenges
>> =======================
>> 1. For EXT2 directory handling which uses page cache and buffer heads, moving that path to 
>>    iomap has challenges with writeback path since iomap also uses folio->private to keep some 
>>    of its internal state (iomap_folio_state).
>> 2. One other thing which was pointed out by Matthew is the BH_Boundary handling currently missing
>>    in iomap. This can lead to non-optimized data I/O patterns causing performance penalty. 
>> 3. Filesystems need a mechanism to validate cached logical->physical block translations 
>>    in iomap writeback code (can this be lifted to common code?)
>> 4. Another missing piece from iomap is the metadata handling for filesystems. There is no
>>    interface which iomap provides that the FS can utilize to move away from buffer heads
>>    for its metadata operations. It can be argued that it is not the responsibility of iomap, however
>>    filesystems do need a mechanism for their metadata handling operations.
>>
>> Proposal
>> =========
>> In this talk I would like to discuss about the efforts, challenges & the lessons learnt in doing the conversion of
>> ext2's DIO and buffered-io paths to iomap, which might help others in conversion of their filesystem.
>> I would also like to have a discussion on the current open challenges we have in converting ext2 (buffered-io path) 
>> and discuss on what ideas people have, which we can consider for transitioning ext* and other filesystems to iomap. 
>>
>> PS: As we speak, I am in the process of rebasing ext2 bufferred-io path to latest upstream kernel. 
>> It's mostly done and I am also looking into some of the open problems listed by community. 


I have rebased the RFC over the latest upstream and implemented the seq
counter approach that was roughly discussed in the RFC patch here [1].
Please find the latest tree at my github [2], in case if anyone is
interested in checking it out.

Currently I am running some tests on this tree as we speak. Post that
will look into BH_Boundary problem.

[1]: https://lore.kernel.org/all/8734wnj53k.fsf@doe.com/
[2]: https://github.com/riteshharjani/linux/commits/ext2-iomap-lsfmm-rfcv2/

-ritesh

>>
>>
>> References
>> ============
>> [1]: https://kernelnewbies.org/KernelProjects/iomap
>> [2]: https://lore.kernel.org/linux-ext4/cover.1682069716.git.ritesh.list@gmail.com/
>> [3]: https://lwn.net/Articles/935934/
>> [4]: https://lore.kernel.org/linux-ext4/cover.1700505907.git.ritesh.list@gmail.com/


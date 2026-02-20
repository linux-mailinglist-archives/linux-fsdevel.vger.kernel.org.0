Return-Path: <linux-fsdevel+bounces-77791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMseIERZmGnLGgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 13:53:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD01679FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 13:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B8A830333ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 12:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925CC30DD3B;
	Fri, 20 Feb 2026 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxrjDOwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87593164D6
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591996; cv=none; b=SViJj7a6gxPr0Rql9loTp0p3btzQ+tNuXnfvi1o9yG/pSKNWWfQtTRdxSeaDdhXndP4zk0w/iwlahrkXzu1c2rEMlUSXd3+BtRqccpXrpXjU7qHphZTWlC+M7Q63mcqzsUGg8iSEG5Ra5TvOZXbmUgurJOM5kY9kZmAXOR44kFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591996; c=relaxed/simple;
	bh=EofTQyMJ9Re5uG6wY+3NnKmWQD+eONA9pJ3YVyucemo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cndxrVrOU9QbZeUlbonhT5QWu9CMfOEbuBiLW/e1lgbRBzShFAbcdqRvfGD7no1Vc9elymjvTLHWzaa27IiClLtClzdJwh3gd4frN37SXZcKSh/UDBi6whNZtLBYzu4pLknqy6jV2p+T+8/N5N/BS20omIdRGdm+WP8DxMDX04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxrjDOwU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43621bf67ceso1369526f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 04:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771591993; x=1772196793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2OR3Y3zmwO62rrO796J5qo5wqKFk0HZtJ3M6GC9gVw8=;
        b=BxrjDOwUg2lT4zusKZ0XoV45YeNsoEe602HkVxVzFO1Zjjbeq7gZ88HIqMhwPCOYkL
         npLTgOzyAPsAplt3I4eGsCPvrRpdShl8wBo+dLuhNMCQEyJFdZ8VPS9Ns7e378tycfBL
         fngoOJazUV1/yltSTkhhgMPHjSLZF7d93J+MfmBpO6dlwM66XutwSVh33lIKpEhwWIji
         RzIeI16JAgiTnAgZkWHdbrvCHN52NOwEycLZbxftkbaktDH6LNxo8BbOESR7JzZ0XoNM
         fMJwykhMERa6529jFIp38euVv2lZlPY/X3SukUMKhw6GolTGHdcJ6kPLnXaFfvYXOP8l
         ttgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771591993; x=1772196793;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OR3Y3zmwO62rrO796J5qo5wqKFk0HZtJ3M6GC9gVw8=;
        b=R1TAkeEvwbmQEnf7x5Xe8BR7ONC3iUgJ7W1Rx7/p0wLjWAowlg//cJub3W3cyYDvFH
         ikSP+0EGT7HFD+MDK/7MABnlnKsVQ2lwYLld7tu6A5TWt3UvKsGYyJMCv+wauJ2job6s
         pIhfsS/srY21lLQyPgxvf3KmeE8bTBvBM7kmwKAR62TMa2N5KC9AhaAJYgnduDBcvpgG
         HMdoao/QpIeJm5MH8g77UdiNb5psqaIs1w2H1HMcTJ/2q8zbAMR7kOLgvM1IzJs4f6R0
         L5497COk2mcGstp7rApHQqR/HPbj0T1slvP7ukBYEL6/Ip+o6C35OYBzFLZCCo7nfPCo
         okKw==
X-Forwarded-Encrypted: i=1; AJvYcCWFCy0XIBMISNpgEST5i3iMts/WjVGbv060aVUs9eajIQhLK2sAq/jOduoyMdqHtKYIODvgvN7NyguK7+mX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tgr3AV3/ocb+60EAVi38BucSYMkcQfeFiqu3IhjaL/ZyJ7kV
	mLAOEIhrUAKLw2M7qnLYLiw+AEvMUOz//sSZla8G50MaYek1y+1rNVUj
X-Gm-Gg: AZuq6aI3ok9QfauAx174Q+yFNPqSKZD+f5VcqIri1GdEbnJuANOrW2zsireRkboDbwK
	hklLuLa+3lsyDtNlHnWiQrnotmem16sOrCIujLQsJSkZI6ThWFZzjAVJ2drr7GDi2wjSGammysQ
	YM+I7ET4VfIrMXjMhWSro6FQ4Cs5/3VSz84VFgTHHJ4LAfyq/YLLamc2mFAReRNwjOUAg1Dl17O
	Pjw5jG/aXRDOFZpsrMMFRnh1YezSasEeDTMredYP67U1cBQaYgi2Xw62TvhFvyG+tu929hUEbqb
	K6GVrFb1yOSeZmrC4lpkARhTf7wTv7b0XoS/pni3izxZemhw/MhOJUGMxekuY7D0IveXRlHkbtt
	EF2yQNNWfIbZyKm7MaIrHFDVCKVnEkInJplvZU1W8cSC9185xOWy1MYYNl6P5WDshL26gReIGVi
	PLWn5LqMdrI7m9UDyMq9gCOMQwML/GH2iVYGlKjHw8Qchs3aLO9KXYE3SO7DwGQqQf/1wH4Nobx
	sZKHQKLa7/NMm4HKioBr9RxoHjpGhkrWZ1LzRmncZLdgftR+QTK5AT50w0=
X-Received: by 2002:a05:6000:3104:b0:430:f742:fbc7 with SMTP id ffacd0b85a97d-4379db34135mr38510688f8f.14.1771591992624;
        Fri, 20 Feb 2026 04:53:12 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796acffcesm53093237f8f.37.2026.02.20.04.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 04:53:12 -0800 (PST)
Message-ID: <11869d3d-1c40-4d49-a6c2-607fd621bf91@gmail.com>
Date: Fri, 20 Feb 2026 12:53:10 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
 io-uring@vger.kernel.org, csander@purestorage.com, krisman@suse.de,
 bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com>
 <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <aYykILfX_u9-feH-@infradead.org>
 <bd488a4e-a856-4fa5-b2bb-427280e6a053@gmail.com>
 <aY7QX-BIW-SMJ3h_@infradead.org>
 <34cf24a3-f7f3-46ed-96be-bf716b2db060@gmail.com>
 <CAJnrk1a+YuPpoLghA01uJhEKrhmrLhQ+5bw2OeeuLG3tG8p6Ew@mail.gmail.com>
 <7a62c5a9-1ac2-4cc2-a22f-e5b0c52dabea@gmail.com>
 <CAJnrk1Y5iTOhj4_RbnR7RJPkr7fFcCdh1gY=3Hm72M91D-SnyQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJnrk1Y5iTOhj4_RbnR7RJPkr7fFcCdh1gY=3Hm72M91D-SnyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77791-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1FD01679FE
X-Rspamd-Action: no action

On 2/18/26 21:43, Joanne Koong wrote:
> On Wed, Feb 18, 2026 at 4:36 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/13/26 22:04, Joanne Koong wrote:
>>> On Fri, Feb 13, 2026 at 4:41 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> ...
>>>> Fuse is doing both adding (kernel) buffers to the ring and consuming
>>>> them. At which point it's not clear:
>>>>
>>>> 1. Why it even needs io_uring provided buffer rings, it can be all
>>>>       contained in fuse. Maybe it's trying to reuse pbuf ring code as
>>>>       basically an internal memory allocator, but then why expose buffer
>>>>       rings as an io_uring uapi instead of keeping it internally.
>>>>
>>>>       That's also why I mentioned whether those buffers are supposed to
>>>>       be used with other types of io_uring requests like recv, etc.
>>>
>>> On the userspace/server side, it uses the buffers for other io-uring
>>> operations (eg reading or writing the contents from/to a
>>> locally-backed file).
>>
> 
> Sorry, I submitted v2 last night thinking the conversation on this
> thread had died. After reading through your reply, I'll modify v2.

No worries at all, and sorry I'm a bit slow to reply

>> Oops, typo. I was asking whether the buffer rings (not buffers) are
>> supposed to be used with other requests. E.g. submitting a
>> IORING_OP_RECV with IOSQE_BUFFER_SELECT set and the bgid specifying
>> your kernel-managed buffer ring.
> 
> Yes the buffer rings are intended to be used with other io-uring
> requests. The ideal scenario is that the user can then do the
> equivalent of IORING_OP_READ/WRITE_FIXED operations on the
> kernel-managed buffers and avoid the per-i/o page pinning overhead
> costs.

You mention OP_READ_FIXED and below agreed not exposing km rings
an io_uring uapi, which makes me believe we're still talking about
different things.

Correct me if I'm wrong. Currently, only fuse cmds use the buffer
ring itself, I'm not talking about buffer, i.e. fuse cmds consume
entries from the ring (!!! that's the part I'm interested in), then
process them and tell the server "this offset in the region has user
data to process or should be populated with data".

Naturally, the server should be able to use the buffers to issue
some I/O and process it in other ways, whether it's a normal
OP_READ to which you pass the user space address (you can since
it's mmap()'ed by the server) or something else is important but
a separate question than the one I'm trying to understand.

So I'm asking whether you expect that a server or other user space
program should be able to issue a READ_OP_RECV, READ_OP_READ or any
other similar request, which would consume buffers/entries from the
km ring without any fuse kernel code involved? Do you have some
use case for that in mind?

Understanding that is the key in deciding whether km rings should
be exposed as io_uring uapi or not, regardless of where buffers
to populate the ring come from.

...
> With it going through a mem region, I don't think it should even go
> through the "pbuf ring" interface then if it's not going to specify
> the number of entries and buffer sizes upfront, if support is added
> for io-uring normal requests (eg IORING_OP_READ/WRITE) to use the
> backing pages from a memory region and if we're able to guarantee that
> the registered memory region will never be able to be unregistered by
> the user. I think if we repurpose the
> 
> union {
>    __u64 addr; /* pointer to buffer or iovecs */
>    __u64 splice_off_in;
> };
> 
> fields in the struct io_uring_sqe to
> 
> union {
>    __u64 addr; /* pointer to buffer or iovecs */
>    __u64 splice_off_in;
>    __u64 offset; /* offset into registered mem region */
> };
> 
> and add some IOSQE_ flag to indicate it should find the pages from the
> registered mem region, then that should work for normal requests.
> Where on the kernel side, it looks up the associated pages stored in
> the io_mapped_region's pages array for the offset passed in.

So you already can do all that using the mmap()'ed region user
pointer, and you just want it to be more efficient, right?
For that let's just reuse registered buffers, we don't need a
new mechanism that needs to be propagated to all request types.
And registered buffer are already optimised for I/O in a bunch
of ways. And as a bonus, it'll be similar to the zero-copy
internally registered buffers if you still plan to add them.

The simplest way to do that is to create a registered buffer out
of the mmap'ed region pointer. Pseudo code:

// mmap'ed if it's kernel allocated.
{region_ptr, region_size} = create_region();

struct iovec iov;
iov.iov_base = region_ptr;
iov.iov_len = region_size;
io_uring_register_buffers(ring, &iov, 1);

// later instead of this:
ptr = region_ptr + off;
io_uring_prep_read(sqe, fd, ptr, ...);

// you use registered buffers as usual:
io_uring_prep_read_fixed(sqe, fd, off, regbuf_idx, ...);


IIRC the registration would fail because it doesn't allow file
backed pages, but it should be fine if we know it's io_uring
region memory, so that would need to be patched.

There might be a bunch of other ways you can do that like
create a kernel allocated registered buffer like what Cristoph
wants, and then register it as a region. Or allow creating
registered buffers out of a region. etc.

I wanted to unify registered buffers and regions internally
at some point, but then drifted away from active io_uring core
infrastructure development, so I guess that could've been useful.

> Right now there's only a uapi to register a memory region and none to
> unregister one. Is it guaranteed that io-uring will never add
> something in the future that will let userspace unregister the memory
> region or at least unregister it while it's being used (eg if we add
> future refcounting to it to track active uses of it)?

Let's talk about it when it's needed or something changes, but if
you do registered buffers instead as per above, they'll be holding
page references and or have to pin the region in some other way.

> If so, then end-to-end, with it going through the mem region, it would
> be something like:
> * user creates a mem region for the io-uring
> * user mmaps the mem region

FWIW, we should just add a liburing helper, so that fuse server
doesn't need to deal with mmap'ing.

> * user passes in offset into region, length of each buffer, and number
> of entries in the ring to the subsystem
> * subsystem creates a locally managed bufring and adds buffers to that
> ring from the mem region

That's sounds clean to me _if_ it allows you to achieve all
(fast path) optimisations you want to have. I hope it does?

-- 
Pavel Begunkov



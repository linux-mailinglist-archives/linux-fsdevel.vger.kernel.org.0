Return-Path: <linux-fsdevel+bounces-17502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55288AE5F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6421F224FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265F184DFF;
	Tue, 23 Apr 2024 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="maFx9ltJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k/Ye/p6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76D85274
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875020; cv=none; b=cNknJKlW5qu0qVuqkONuBSdScSBwTcFjOV8SypQdA8COQpwo5B4HRbm+tY1UYSISszzjMj0+GPr7d/fRIy7MgmidlzTxo1b2i0A9ICaZ1ScGh2QFyTjz+ovFdKfiF0VGtlxH31Jo0ztReJyNPY8/bjoIRgODZVnS/b+fLbq0TeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875020; c=relaxed/simple;
	bh=pxzdPlgGndn3j9E1ty5OcUZ0UI98kXn2MfDtqqsoLUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzVllEbcZ82QITZ8ipV4zNKc5AjNGUdg09S1lTqNnmoFXNbfKGw4jQzhny5YD2lSH9tDgDp3ScL6ZU27il0evnISFKjQWlOp47O3RduRMagcws2PKFJmkWusf2sFDZLxHZrgUnvSZWbUsf+JsARgMpDQHbRiKTFwYYUVTMCCVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=maFx9ltJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k/Ye/p6a; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0115C11400A2;
	Tue, 23 Apr 2024 08:23:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 Apr 2024 08:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1713875016;
	 x=1713961416; bh=4sF8IDgqjFVDpffkmfGWQjNm2mjp6o6UJSa5jo3ddGI=; b=
	maFx9ltJq/jsmJpuz3hyLQFPcKdMfPhRQpg+auq1Dt8UqynOEDh7UK804n4qqA5z
	/EwTRJakGfFN4uA+p0FWksXo9R2HRV3k7Ipty3sp9qdSwZbBJjXpj2j9H7qfix6c
	xXZBn9gApLwuRYbwQKW6qVHpdKXh6WacKEqb9v2HKIYQtlNTt/fTnYI/syYUT8T3
	eGW/la9hzzHJOiOUogcaqraZUmcrul+rt6zpnabuRNPKTU5Uy6KgBFTAAuNs3Sck
	g3zbpyjHQajUboka0JbUG8PM55sRiGYH/zLQJGiDE3ev3mQ37PCKKq+rtrZCIf/t
	MR/grpE7BewcuBwdxcKmcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713875016; x=
	1713961416; bh=4sF8IDgqjFVDpffkmfGWQjNm2mjp6o6UJSa5jo3ddGI=; b=k
	/Ye/p6aCY6NTVVIGhglld7sFN7yVWMdBwUe8nCVl9gHLXocZtxnHxVvj55rd4QSv
	onIxQ0vLT8B+FQiIF3LtkfybB5zFu8of8kN0CisgxQfz33SSkmy9iyYYW+M5EFWD
	JMt449UoyhDdCeAnzIdMOlc2hTrH7oW57LS+iA2ajgth3uhuDk+H8voU5hpJE++8
	nkDNDcb7Xfo1PcO7gOc19InfkJUttt5TJ5IlzRPHI3YgiiZj77O3BaDIm2ymIITS
	+SkJjYlrGg9jMMeGucbfwFv/Mg3z6zjG1Fhnp2l/9qwEsNdozv0UGEPRPoLcDju2
	A290fCdFwT8ve2yfNRa2w==
X-ME-Sender: <xms:SKgnZs2V7ScWhMDuyPmBcn4qBU6R6aCWys5hxP36t-ZGwq9JDwZdZg>
    <xme:SKgnZnESsZt2oh_Kbdp0NFvp2TIZ_QOb-si7K1Gbpx9KCO9eZKVCw4PBbGxmgY1ff
    XuqmaZWtuyxBN-M>
X-ME-Received: <xmr:SKgnZk64glaWikKuIy20Da5CSe3r6Ia9CEhUn4wTnmoIjbom4bVZWyIi5lW9uQTm5PEP1Bo9hh7kdKHs3RcyaC4sxkY1dhbFIegRwYhtWKZ5cvIRkNrH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:SKgnZl35CRg0p5F0L1sSKyJrEYvvWUMJTr5ENu6ZVktd1ievJS1jvw>
    <xmx:SKgnZvF-SPYgNnlCjiY5_XGMOcmWJ6KPUnvmLza1txO6afd_k-GA9Q>
    <xmx:SKgnZu8u_YPF0cr7LzXnQ-rFyKBTlbW26fKqq9TZ_Q5xwzN_kBsCZw>
    <xmx:SKgnZklH6aPopEBPfFq6d7llRwBggTO5nu3SkSd9VQT8jKGj7XFVdw>
    <xmx:SKgnZnDj_GIZeqQD1NEY7ak2r2-rSQ0w7mBR55A5Iq5IBshMZALxupOO>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 08:23:35 -0400 (EDT)
Message-ID: <7c22c836-2be4-49b6-90ac-afebe454c42e@fastmail.fm>
Date: Tue, 23 Apr 2024 14:23:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse: Avoid fuse_file_args null pointer dereference
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Amir Goldstein <amir73il@gmail.com>
References: <b923f900-3e09-4c6e-a199-05053376d7c2@fastmail.fm>
 <CAJfpegtQ9tFH=7vUtG+UCZnABYkhmHBRgWazrKGfGtYatHUvOw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegtQ9tFH=7vUtG+UCZnABYkhmHBRgWazrKGfGtYatHUvOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/24 12:46, Miklos Szeredi wrote:
> On Mon, 22 Apr 2024 at 19:40, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>> The test for NULL was done for the member of union fuse_file_args,
>> but not for fuse_file_args itself.
>>
>> Fixes: e26ee4efbc796 ("fuse: allocate ff->release_args only if release is needed")
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>
>> ---
>> I'm currently going through all the recent patches again and noticed
>> in code review. I guess this falls through testing, because we don't
>> run xfstests that have !fc->no_opendir || !fc->no_open.
>>
>> Note: Untested except that it compiles.
>>
>> Note2: Our IT just broke sendmail, I'm quickly sending through thunderbird,
>> I hope doesn't change the patch format.
>>
>>   fs/fuse/file.c |    7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index b57ce4157640..0ff865457ea6 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -102,7 +102,8 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
>>   static void fuse_file_put(struct fuse_file *ff, bool sync)
>>   {
>>         if (refcount_dec_and_test(&ff->count)) {
>> -               struct fuse_release_args *ra = &ff->args->release_args;
>> +               struct fuse_release_args *ra =
>> +                       ff->args ? &ff->args->release_args : NULL;
> 
> While this looks like a NULL pointer dereference, it isn't, because
> &foo->bar is just pointer arithmetic, and in this case the pointers
> will be identical.  So it will work, but the whole ff->args thing is a
> bit confusing.   Not sure how to properly clean this up, your patch
> seems to be just adding more obfuscation.

Hmm, right, I had actually thought about that and written a small test,
before creating the patch. But then had it slightly different - caused
the null-ptr deref.
Updated code works, but UBSAN still complains.


bschubert2@imesrv6 test>./test-union
test-union.c:23:10: runtime error: member access within null pointer of
type 'union bar'
No ptr


cat test-union.c

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

union bar
{
    int foo;
    int foo2;
};

struct test
{
    union bar *bar;
};

int main(void)
{
    struct test *test = calloc(1, sizeof(test));
    assert(test);

    int *foo_ptr = &test->bar->foo;

    if (foo_ptr)
        printf("Have ptr\n");
    else
        printf("No ptr\n");

    free(test);

    return 0;
}



Thanks,
Bernd

